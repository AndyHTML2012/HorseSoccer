extends Node3D
signal fly
@export var Speed : float
@export var GoalieSpeed : float 


func _on_area_3d_body_entered(body):
	if (body.name == "Ball"):
		emit_signal("fly", Speed)
