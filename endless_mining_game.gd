extends Node3D

const CUBE_PACKED = preload("res://cube_pfb.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_cubes.call_deferred()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $cubes.get_child_count() == 0:
		spawn_cubes()

func spawn_cubes() -> void:
	# reset player pos to 0,0,0
	# despawn all cubes (?)
	for x in range(-1,1+1):
		for z in range(-1,1+1):
			for y in range(-2,1+1):
				match [x,y,z]:
					[0,0,0], [0,-1,0]:
						pass
					_:
						spawn_cube(x,y,z)
						
func spawn_cube(x:int,y:int,z:int) -> void:
	var cubepos:=Vector3(x,y,z)
	var cube:=CUBE_PACKED.instantiate()
	cube.position = cubepos
	$cubes.add_child(cube)
	cube.owner = owner if owner else self
