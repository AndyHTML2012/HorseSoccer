extends Camera3D

@export var target: Node3D
var targetPos
# Called when the node enters the scene tree for the first time.
func _ready():
	targetPos = Vector3(0,0,0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var lookat_pos = target.global_position
	look_at(lookat_pos+Vector3(0,2,0))
	targetPos = target.get_node("Camera").global_position+Vector3(0,5,0);
	self.position = self.position.lerp(targetPos, delta*3.0)
	pass
