extends CSGBox3D

var highlighted : bool :
	set (v) : 
		pass
		#rotation.x += 1
		#scale = Vector3.ONE * (1.2 if highlighted else 0.8)
		#flip_faces = highlighted
		#var m := (material as StandardMaterial3D)
		#m.albedo_color = (
			#Color.RED if highlighted
			#else Color.WHITE
		#)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if randf() < 0.01:
		highlighted = randf() < 0.5
