extends Node
signal goal


func _on_area_3d_body_entered(body):
	if (body.name == "Ball"):
		emit_signal("goal")
		get_parent().get_node("Ball")
		print("signal activated")
	
	

