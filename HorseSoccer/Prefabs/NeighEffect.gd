extends AudioStreamPlayer




func _on_flying_horse_neigh():
	if (!playing):
		play()
