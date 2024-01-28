extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("test1"):
		get_node("Neigh").play()
	if Input.is_action_just_pressed("test2"):
		get_node("NiceClop").play()
	if Input.is_action_just_pressed("test2"):
		get_node("Cheer").play()
	
	
