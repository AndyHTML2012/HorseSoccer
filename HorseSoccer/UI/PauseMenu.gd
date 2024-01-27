extends Control

func _on_resume_button_pressed():
	get_tree().paused = false
	visible = false

func _on_back_to_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Levels/MainMenu.tscn")

func _on_quit_game_button_pressed():
	get_tree().quit()
