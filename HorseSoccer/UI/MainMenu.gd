extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	
# Play Audio
	var audio_stream = preload("res://Audio/sound-effect-twinklesparkle-115095.mp3")
	var audio_player = AudioStreamPlayer2D.new()
	audio_player.stream = audio_stream
	add_child(audio_player)
	audio_player.play()
	
	# Wait for the sound to finish, then switch scenes
	await audio_player.finished
	
	get_tree().change_scene_to_file("res://RoryScene.tscn")


func _on_miscellaneous_button_pressed():
	
	# Play Audio
	var audio_stream = preload("res://Audio/sound-effect-twinklesparkle-115095.mp3")
	var audio_player = AudioStreamPlayer2D.new()
	audio_player.stream = audio_stream
	add_child(audio_player)
	audio_player.play()
	
	# Wait for the sound to finish, then switch scenes
	await audio_player.finished
	
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()
