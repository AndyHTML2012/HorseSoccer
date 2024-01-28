extends Node3D



func _on_area_3d_body_entered(body):
	if (body.name == "Horse"):
		get_node("RigidBody3D/ChildAnimation/AnimationPlayer").play("ChildDancing")
