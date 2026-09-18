extends Node3D

const CUBE_PACKED = preload("res://cube_pfb.tscn")

const MIDDLE_SUNX = -90.
const AMPLTD_SUNX = (90-24.2)
var _sunphase : float
var sunphase : float :
	get : return _sunphase
	set (v) :
		_sunphase = v
		$sunrot.rotation_degrees.x = MIDDLE_SUNX + AMPLTD_SUNX * sin(v)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_cubes.call_deferred()
	sunphase = randf() * PI * 2
	#-24.2, 24.2-180

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sunphase += 0.03 * delta
	if $player.position.y < -100:
		spawn_cubes()
		$player.stopfalling()

func spawn_cubes() -> void:
	for cube in $cubes.get_children(): cube.queue_free()
	# reset player pos to 0,0,0
	# despawn all cubes (?)
	for x in range(-1,1+1):
		for z in range(-1,1+1):
			for y in range(-2,1+1):
				match [x,y,z]:
					[0,0,0], [0,-1,0]:
						pass
					[0,-2,0]:
						spawn_cube(x,y,z).tree_exited.connect(func(): $player.startfalling())
					_:
						spawn_cube(x,y,z)
						
func spawn_cube(x:int,y:int,z:int) -> Node3D:
	var cubepos:=Vector3(x,y,z)
	var cube:=CUBE_PACKED.instantiate()
	cube.position = cubepos
	$cubes.add_child(cube)
	cube.owner = owner if owner else self
	return cube
