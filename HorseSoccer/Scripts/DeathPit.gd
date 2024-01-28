extends Area3D
signal Death


func _on_area_3d_body_entered(body):
	if (body.name == "Horse" || body.name == "Ball"):
		emit_signal("Death")
