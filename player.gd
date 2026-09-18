extends Node3D

var falling : bool = false
var fallvelocity : float = 0.0
var recoverspd : float = 1.0

func startfalling() -> void:
	falling = true
	
func stopfalling() -> void:
	falling = false
	position = Vector3(0,-randf_range(0.15,0.25),0)
	fallvelocity = 0.0
	recoverspd = randf_range(1.0, 2.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if falling:
		position.y -= fallvelocity * delta
		fallvelocity += 9.81 * delta
	else:
		position.y = move_toward(position.y, 0, recoverspd*delta)
