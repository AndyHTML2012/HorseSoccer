extends Control

@onready var _animation_player = $SparkleAnimation

func play_sparkle():
	_animation_player.visible = true
	# Play the animation
	_animation_player.play("sparkle")
	# Connect the animation_finished signal to a function
	_animation_player.animation_finished.connect(_on_AnimatedSprite2D_animation_finished)

func _on_AnimatedSprite2D_animation_finished():
	# Hide the AnimatedSprite2D
	_animation_player.hide()
	_animation_player.visible = false

func _on_play_button_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	$ClickSFX.play()
	play_sparkle()
	await $ClickSFX.finished
	get_tree().change_scene_to_file("res://RoryScene.tscn")

func _on_miscellaneous_button_pressed():
	$ClickSFX.play()
	play_sparkle()
	await $ClickSFX.finished
	#get_tree().change_scene_to_file("res://UI/MiscellaneousMenu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_tutorial_button_pressed():
	$ClickSFX.play()
	play_sparkle()
	await $ClickSFX.finished
	get_tree().change_scene_to_file("res://UI/TutorialScreen.tscn")
