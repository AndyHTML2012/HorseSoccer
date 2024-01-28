extends RigidBody3D
signal StopAnim
signal StartAnim
signal Neigh
signal BallTime
var HorseyDefault
var HorseyDefaultRot
var IsGoalReached : bool
var Ball : RigidBody3D

func _ready():
	HorseyDefault = global_position
	HorseyDefaultRot = global_rotation
	Ball = get_parent().get_parent().get_node("Ball")

func _on_horse_goalie_fly(speed):
	print("Flying")
	emit_signal("StopAnim")
	emit_signal("Neigh")
	var BallPosition = Ball.global_position
	var Horsey : Vector3 = global_position
	var BallDirection = Horsey.direction_to(BallPosition)
	set_freeze_enabled(false)
	add_constant_central_force(BallDirection*speed)
	var ResetT = $"../ResetTimer"
	if (!IsGoalReached):
		ResetT.start()

func _on_netmodel_goal():
	IsGoalReached = true
	var BallTimer = Timer.new()
	add_child(BallTimer)
	BallTimer.wait_time = 0.2
	BallTimer.one_shot = true
	BallTimer.timeout.connect(_on_ball_time)
	BallTimer.start()
	

func _on_reset_timer_timeout():
	if (!IsGoalReached):
		global_position = HorseyDefault
		global_rotation = HorseyDefaultRot
		constant_force = Vector3(0, 0, 0)
		emit_signal("StartAnim")



func _on_ball_time():
	Ball.set_freeze_enabled(true)
