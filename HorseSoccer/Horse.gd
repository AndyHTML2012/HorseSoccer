extends CharacterBody3D


const SPEED = 0.6
const TURN_SPEED = 4.0
const JUMP_VELOCITY = 10
const MAX_VELOCITY = 10.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var movement = input_dir.y
	if movement:
		velocity.x += movement * SPEED * transform.basis.z.x
		velocity.z += movement * SPEED * transform.basis.z.z
	else:
		velocity.x = move_toward(velocity.x, 0, delta*10.0)
		velocity.z = move_toward(velocity.z, 0, delta*10.0)

	velocity.x = clamp(velocity.x, -MAX_VELOCITY, MAX_VELOCITY)
	velocity.z = clamp(velocity.z, -MAX_VELOCITY, MAX_VELOCITY)
	print(str(transform.basis))
	var rot_value = -input_dir.x*TURN_SPEED*delta;
	rotation_degrees.z += rot_value * 30.0;
	rotation_degrees.z = move_toward(rotation_degrees.z, 0, delta*70.0)
	rotate_y(rot_value);
	move_and_slide()
