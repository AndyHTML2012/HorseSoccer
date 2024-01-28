extends Node3D
var LevelManager

func _ready():
	LevelManager = get_parent().get_node("LevelManager")

func _on_area_3d_body_entered(body):
	if (body.name == "Horse" || body.name == "Ball"):
		get_node("RigidBody3D/ChildAnimation/AnimationPlayer").play("ChildDancing")
		if LevelManager.DoesChildKill:
			LevelManager.emit_signal("Death")
