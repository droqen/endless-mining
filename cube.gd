extends CSGBox3D

var highlighted : bool :
	set (v) : 
		if v : scale = Vector3.ONE * 0.5
		else : scale = Vector3.ONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	highlighted = randf() < 0.5
