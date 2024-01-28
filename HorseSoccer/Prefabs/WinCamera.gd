extends Camera3D
var Goalie


func _ready():
	if (get_parent().has_node("netmodel")):
		Goalie = get_parent().get_node("netmodel")
	else:
		Goalie = get_parent().get_node("HorseGoalie/netmodel")
	
	Goalie.goal.connect(_on_netmodel_goal)

func _on_netmodel_goal():
	current = true
	var Animator : AnimationPlayer = get_node("AnimationPlayer")
	Animator.play("CameraWin")
