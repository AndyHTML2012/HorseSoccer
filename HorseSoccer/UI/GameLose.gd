extends Control
var horse = null

func _ready():
	var root = get_tree().get_root()
	horse = root.get_node("Horse")
	if horse == null:
		$VBoxContainer/BallHitsLabel.text = "Ball Hits: n/a"
	else:
		$VBoxContainer/BallHitsLabel.text = "Ball Hits:" + horse.num_ball_hits

func _on_restart_button_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	visible = false
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://Levels/MainMenu.tscn")
