extends RigidBody3D


const SPEED = 20.0
const TURN_SPEED = 4.0
const JUMP_VELOCITY = 10
const MAX_VELOCITY = 10.0



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var mousedelta = 0

func _input(event):
	if event is InputEventMouseMotion:
		mousedelta = event.relative.x * 0.02


func _physics_process(delta):
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y -= gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "forward", "backward")
	
	var movement = input_dir.y
	if movement:
		constant_force.x = movement * SPEED * transform.basis.z.x
		constant_force.z = movement * SPEED * transform.basis.z.z
	else:
		constant_force.x = move_toward(constant_force.x, 0, delta*10.0)
		constant_force.z = move_toward(constant_force.z, 0, delta*10.0)

	#constant_force.x = clamp(constant_force.x, -MAX_VELOCITY, MAX_VELOCITY)
	#constant_force.z = clamp(constant_force.z, -MAX_VELOCITY, MAX_VELOCITY)
	print(str(transform.basis))
	if (Input.is_action_just_pressed("ui_cancel")):
		if (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
	
	var rot_value = -mousedelta*TURN_SPEED*delta;
	rotation_degrees.z += rot_value * 30.0;
	rotation_degrees.z = move_toward(rotation_degrees.z, 0, delta*150.0)
	rotation_degrees.x = move_toward(rotation_degrees.x, 0, delta*150.0)
	rotate_y(rot_value);

	
	#physics push:

