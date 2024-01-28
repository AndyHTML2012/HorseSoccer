extends Node
var ApplauseSoundPlayer : AudioStreamPlayer
var NiceClopPlayer : AudioStreamPlayer
var Goalie

func _ready():
	if (get_parent().has_node("netmodel")):
		Goalie = get_parent().get_node("netmodel")
	else:
		Goalie = get_parent().get_node("HorseGoalie/netmodel")
	Goalie.goal.connect(OnGoal)
	ApplauseSoundPlayer = get_node("ApplauseSoundPlayer")
	NiceClopPlayer = get_node("NiceClopPlayer")
	


func OnGoal():
	ApplauseSoundPlayer.play()
	NiceClopPlayer.play()



func _on_death_pit_body_entered(body):
	if (body.name == "Horse" || body.name == "Ball"):
		get_tree().reload_current_scene()
