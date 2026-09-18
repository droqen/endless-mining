extends Camera3D

@export var pitch : float = 0.0
@export var yaw : float = 0.0
@export var turnspeed_mult : float = 3.0
var mouse_locked : bool :
	get : return Input.mouse_mode == Input.MouseMode.MOUSE_MODE_CAPTURED
	set (v) : Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if v else Input.MOUSE_MODE_VISIBLE

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var kevent : InputEventKey = event
		if kevent.pressed and kevent.keycode == KEY_ESCAPE and mouse_locked:
			mouse_locked = false
	if event is InputEventMouseButton:
		if event.pressed: mouse_locked = true
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

func _process(_delta: float) -> void:
	rotation = Vector3(-pitch, -yaw, 0)
