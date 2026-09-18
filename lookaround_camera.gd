extends Camera3D

@export var pitch : float = 0.0
@export var yaw : float = 0.0
@export var turnspeed_mult : float = 3.0
var mouse_locked : bool :
	get : return Input.mouse_mode == Input.MouseMode.MOUSE_MODE_CAPTURED
	set (v) :
		if v :
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
var mouse_held : bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var kevent : InputEventKey = event
		if kevent.pressed and kevent.keycode == KEY_ESCAPE and mouse_locked:
			mouse_locked = false
	if event is InputEventMouseButton:
		if event.pressed:
			mouse_locked = true
			mouse_held = true
			click()
		else:
			mouse_held = false
	if event is InputEventMouseMotion and mouse_locked:
		var moevent : InputEventMouseMotion = event
		var screensize := get_window().size
		yaw = fposmod(yaw +
			turnspeed_mult
				* moevent.screen_relative.x
				/ screensize.x,
			PI * 2)
		pitch = clampf(pitch +
			turnspeed_mult
				* moevent.screen_relative.y
				/ screensize.y,
			-PI * 0.5, PI * 0.5)

func _process(delta: float) -> void:
	rotation = Vector3(-pitch, -yaw, 0)
	if mouse_held:
		$Shoulder.rotate_x(delta * -10)
	else:
		if $Shoulder.rotation.x < 1:
			$Shoulder.rotate_x(delta * 5)
	$Shoulder/ArmHinge.look_at(position + basis.z * 1 + basis.x * 0.5 + basis.y * -1)

func click() -> void:
	var collider = $RayCast3D.get_collider()
	if collider:
		var mousetarget = collider.get_parent()
		print(mousetarget)
		mousetarget.queue_free()
