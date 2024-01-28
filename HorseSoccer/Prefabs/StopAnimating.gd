extends AnimationPlayer








func _on_flying_horse_stop_anim():
	stop(true)


func _on_flying_horse_start_anim():
	play("Goalie")
