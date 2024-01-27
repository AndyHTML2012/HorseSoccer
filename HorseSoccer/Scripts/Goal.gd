extends Node
signal goal


func _ready():
	get_node("Area3D")




func _on_area_3d_body_entered(body):
	if (body.name == "ball"):
		emit_signal("goal")
		print("signal activated")
	
	

