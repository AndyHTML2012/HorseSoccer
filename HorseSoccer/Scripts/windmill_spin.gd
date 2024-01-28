extends Node3D
var WindmillObject : Node3D

func _ready():
	WindmillObject = $Windmill

func _physics_process(delta):
	WindmillObject.rotate_x(1*delta)
