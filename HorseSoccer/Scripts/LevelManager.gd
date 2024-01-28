extends Node
var ApplauseSoundPlayer : AudioStreamPlayer
var NiceClopPlayer : AudioStreamPlayer

func _ready():
	var Goalie = get_parent().get_node("HorseGoalie/netmodel")
	Goalie.goal.connect(OnGoal)
	ApplauseSoundPlayer = get_parent().get_node("ApplauseSoundPlayer")
	NiceClopPlayer = get_parent().get_node("NiceClopPlayer")
	


func OnGoal():
	ApplauseSoundPlayer.play()
	NiceClopPlayer.play()



func _on_death_pit_body_entered(body):
	if (body.name == "Horse" || body.name == "Ball"):
		get_tree().reload_current_scene()
