extends RigidBody3D
signal StopAnim
signal StartAnim
var HorseyDefault
var HorseyDefaultRot
var IsGoalReached : bool
var Ball

func _ready():
	HorseyDefault = global_position
	HorseyDefaultRot = global_rotation

func _on_horse_goalie_fly():
	print("Flying")
	emit_signal("StopAnim")
	Ball = $"../Ball"
	var BallPosition = Ball.global_position
	var Horsey : Vector3 = global_position
	var BallDirection = Horsey.direction_to(BallPosition)
	set_freeze_enabled(false)
	add_constant_central_force(BallDirection*100)
	var ResetT = $"../ResetTimer"
	if (!IsGoalReached):
		ResetT.start()

func _on_netmodel_goal():
	Ball.set_freeze_enabled(true)

func _on_reset_timer_timeout():
	global_position = HorseyDefault
	global_rotation = HorseyDefaultRot
	constant_force = Vector3(0, 0, 0)
	emit_signal("StartAnim")
	



	
