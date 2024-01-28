extends RigidBody3D

@export var trackentity: PackedScene
@export var driftlabel: RichTextLabel
@export var ballentity: RayCast3D

const SPEED = 700.0
const TURN_SPEED = 4.0
const JUMP_VELOCITY = 10
const MAX_VELOCITY = 10.0

const MASS = 20.0

var spawn_trail = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var floorcheck
var mousedelta = 0
var spawncount = 0.0

var mass_modifier = 0.0

var movedirection

var drift_value = 0.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	movedirection = Vector3(0,0,0)
	floorcheck = get_node("FloorCheck")

func _input(event):
	if event is InputEventMouseMotion:
		mousedelta = event.relative.x * 0.05


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	
	if (Input.is_action_just_pressed("jump") and floorcheck.is_colliding()):
		apply_central_impulse(Vector3(0, 300, 0))

	if (Input.is_action_just_pressed("forward") or Input.is_action_just_pressed("backward")):
		movedirection = transform.basis.z

	driftlabel.text = str(int(drift_value))
	#if (Input.is_action_pressed("forward") and global_position.distance_to(ballentity.global_position) < 20):
	#	print("adding force")
	#	apply_central_force(2000.0*delta*(ballentity.global_position-global_position))
	if input_dir:
		constant_force.x = input_dir.y * (SPEED) * movedirection.x
		constant_force.z = input_dir.y * (SPEED) * movedirection.z
		drift_value+=delta*4.0
		mass_modifier+=delta*5.0
	else:
		linear_velocity.x = 0
		linear_velocity.z = 0
		mass_modifier = 0
	#if (Input.is_action_pressed("break")):
	#	constant_force.x = 0
	#	constant_force.z = 0

	mass = MASS+mass_modifier

	#constant_force.x = clamp(constant_force.x, -MAX_VELOCITY, MAX_VELOCITY)
	#constant_force.z = clamp(constant_force.z, -MAX_VELOCITY, MAX_VELOCITY)

	if (Input.is_action_just_pressed("ui_cancel")):
		if (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		

	var rot_value = -Input.get_axis("left", "right")*TURN_SPEED*delta;
	#rotation_degrees.z += rot_value * 50.0;
	mass = MASS + absf(rotation_degrees.z)
	#rotation_degrees.z = move_toward(rotation_degrees.z, 0, delta*150.0)
	#rotation_degrees.x = move_toward(rotation_degrees.x, 0, delta*150.0)
	rotate_y(rot_value);

	#spawn track

	if (!spawn_trail):
		return
	spawncount+=delta
		
	if (spawncount > 0.05):
		spawncount = 0
		#track 1
		var track = trackentity.instantiate()
		track.position = get_node("TrackSpawn").global_position
		track.rotation = get_node("TrackSpawn").global_rotation
		get_node("/root/").add_child(track)
		
		#track 2
		var track2 = trackentity.instantiate()
		track2.position = get_node("TrackSpawn2").global_position
		track2.rotation = get_node("TrackSpawn2").global_rotation
		get_node("/root/").add_child(track2)

