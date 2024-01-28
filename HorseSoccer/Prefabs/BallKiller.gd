extends Node3D


func _on_area_3d_body_entered(body):
	if (body.name == "Ball"):
		get_parent().get_node("LevelManager").emit_signal("Death")
