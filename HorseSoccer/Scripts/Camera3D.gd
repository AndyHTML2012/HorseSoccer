extends Camera3D

# Preload the pause menu scene
var PauseMenuScene = preload("res://UI/PauseMenu.tscn")
var pause_menu = PauseMenuScene.instantiate()

var paused = false

@export var target: Node3D

var targetPos
# Called when the node enters the scene tree for the first time.
func _ready():
	# pause menu init
	add_child(pause_menu)
	pause_menu.visible = false
	
	targetPos = Vector3(0,0,0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("pauseGame"):
		paused = true
		pauseGame()
	
	var lookat_pos = target.global_position
	look_at(lookat_pos+Vector3(0,2,0))
	targetPos = target.get_node("Camera").global_position+Vector3(0,5,0);
	self.position = self.position.lerp(targetPos, delta*3.0)
	pass

# pause game and display pause menu
func pauseGame():
	if paused:
		pause_menu.visible = true
		get_tree().paused = true
		paused = !paused
		
