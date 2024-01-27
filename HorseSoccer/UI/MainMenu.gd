extends Control

func _on_play_button_pressed():
	$ClickSFX.play()
	await $ClickSFX.finished
	get_tree().change_scene_to_file("res://RoryScene.tscn")

func _on_miscellaneous_button_pressed():
	$ClickSFX.play()
	await $ClickSFX.finished
	get_tree().change_scene_to_file("res://UI/MiscellaneousMenu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_tutorial_button_pressed():
	$ClickSFX.play()
	await $ClickSFX.finished
	get_tree().change_scene_to_file("res://UI/TutorialScreen.tscn")
