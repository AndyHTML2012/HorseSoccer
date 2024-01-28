extends Node
var ApplauseSoundPlayer : AudioStreamPlayer
var NiceClopPlayer : AudioStreamPlayer
var Goalie
signal Death

func _ready():
	if (get_parent().has_node("netmodel")):
		Goalie = get_parent().get_node("netmodel")
	else:
		Goalie = get_parent().get_node("HorseGoalie/netmodel")
	Goalie.goal.connect(OnGoal)
	ApplauseSoundPlayer = get_node("ApplauseSoundPlayer")
	NiceClopPlayer = get_node("NiceClopPlayer")
	connect("Death", Dying)
	


func OnGoal():
	$UIFadeIn.play("FadeInWinner")
	ApplauseSoundPlayer.play()
	NiceClopPlayer.play()


func _on_death_pit_body_entered(body):
	if (body.name == "Horse" || body.name == "Ball"):
		emit_signal("Death")

func Dying():
	$UIFadeIn.play("FadeInLoser")
