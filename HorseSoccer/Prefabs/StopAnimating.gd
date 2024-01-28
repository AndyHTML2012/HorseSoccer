extends AnimationPlayer



func _ready():
	speed_scale = get_parent().GoalieSpeed




func _on_flying_horse_stop_anim():
	stop(true)


func _on_flying_horse_start_anim():
	play("Goalie")
