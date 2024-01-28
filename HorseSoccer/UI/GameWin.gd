extends Control

var horse_node = null

func _ready():
	horse_node = get_node("res://Horse")
	if horse_node == null:
		$VBoxContainer/BallHitsLabel.text = "Ball Hits: n/a"
	else:
		$VBoxContainer/BallHitsLabel.text = "Ball Hits:" + horse_node.num_ball_hits

func _on_restart_button_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	visible = false
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://Levels/MainMenu.tscn")


func _on_next_lvl_button_pressed():
	get_tree().change_scene_to_packed(get_parent().NextLevel)
