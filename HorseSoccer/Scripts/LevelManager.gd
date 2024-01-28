extends Node
var ApplauseSoundPlayer : AudioStreamPlayer
var NiceClopPlayer : AudioStreamPlayer
var Failure : AudioStreamPlayer
var Goalie
@export var NextLevel : PackedScene
@export var DoesChildKill : bool
signal Death

# Preload the winner menu scene
var WinMenuScene = preload("res://UI/GameWin.tscn")
var winnerScreen = WinMenuScene.instantiate()

func _ready():
	# win menu init
	add_child(winnerScreen)
	winnerScreen.visible = false
	
	if (get_parent().has_node("netmodel")):
		Goalie = get_parent().get_node("netmodel")
	else:
		Goalie = get_parent().get_node("HorseGoalie/netmodel")
	Goalie.goal.connect(OnGoal)
	ApplauseSoundPlayer = get_node("ApplauseSoundPlayer")
	NiceClopPlayer = get_node("NiceClopPlayer")
	Failure = get_node("Failure")
	connect("Death", Dying)
	


func OnGoal():
	#$UIFadeIn.play("FadeInWinner")
	Show_GameWinScreen()
	ApplauseSoundPlayer.play()
	NiceClopPlayer.play()


func _on_death_pit_body_entered(body):
	if (body.name == "Horse" || body.name == "Ball"):
		emit_signal("Death")

func Dying():
	$UIFadeIn.play("FadeInLoser")
	Failure.play()
	var RestartTimer = Timer.new()
	add_child(RestartTimer)
	RestartTimer.wait_time = 5.5
	RestartTimer.one_shot = true
	RestartTimer.timeout.connect(Restart)
	RestartTimer.start()

func _input(event):
	if Input.is_key_pressed(KEY_R):
		Restart()
func Restart():
	get_tree().reload_current_scene()
	
func Show_GameWinScreen():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	winnerScreen.visible = true
	

func Show_GameLoseScreen():
	pass
