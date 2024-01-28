extends RigidBody3D

@export var trackentity: PackedScene
@export var driftlabel: RichTextLabel
@export var ballentity: RayCast3D
@export var linemesh : MeshInstance3D
@export var model : MeshInstance3D

const SPEED = 8.0
const TURN_SPEED = 2.5
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

var linescale = 1000

var horse_tilt = 0
var tilt_delta = 0
var hit_ball = false

var num_ball_hits = 0
var can_hit = true

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	movedirection = Vector3(0,0,0)
	floorcheck = get_node("FloorCheck")
	contact_monitor = true
	max_contacts_reported = 10

func _input(event):
	if event is InputEventMouseMotion:
		mousedelta = event.relative.x * 0.05


func _physics_process(delta):
	hit_ball = false
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.name == "Ball":
			print("hit ball")
			hit_ball = true
			pass
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_axis("forward", "backward")
	tilt_delta = 0
	spawn_trail = false
	#if (Input.is_action_just_pressed("jump") and floorcheck.is_colliding()):
	#	apply_central_impulse(Vector3(0, 100000, 0))
	#	print("JUMP")

	if (Input.is_action_pressed("forward") or Input.is_action_pressed("backward") or Input.is_action_just_pressed("launch")):
		movedirection = transform.basis.z
		
		
	if (Input.is_action_pressed("drift")):
		linemesh.scale = Vector3(1,1,linescale)
		linemesh.position.z = -linescale/20.0
	else:
		linemesh.scale = Vector3(0,0,0)
	
	
	driftlabel.text = str(num_ball_hits)
	#if (Input.is_action_pressed("forward") and global_position.distance_to(ballentity.global_position) < 20):
	#	print("adding force")
	#	apply_central_force(2000.0*delta*(ballentity.global_position-global_position))
	if (Input.is_action_pressed("launch")):
		linear_velocity.x = -(SPEED) * movedirection.x * 6
		linear_velocity.z = -(SPEED) * movedirection.z * 6
		drift_value+=delta*4.0
		mass_modifier+=delta*5.0
		rotate_y(delta)
		tilt_delta += delta*0.3
		if floorcheck.is_colliding():
			spawn_trail = true
		if (hit_ball == true && can_hit == true):
			can_hit = false
			num_ball_hits+=1
		#Engine.time_scale = move_toward(Engine.time_scale, 0.1, delta*10.0)
	elif input_dir:
		if (hit_ball == true && can_hit == true):
			can_hit = false
			num_ball_hits+=1
		#Engine.time_scale = move_toward(Engine.time_scale, 1.0, delta)
		linear_velocity.x = input_dir * (SPEED) * movedirection.x
		linear_velocity.z = input_dir * (SPEED) * movedirection.z
	else:
		can_hit = true
		#Engine.time_scale = move_toward(Engine.time_scale, 1.0, delta)
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
		

	var rot_value = -Input.get_axis("left", "right")*TURN_SPEED*delta + -mousedelta*delta*0.2;
	#rotation_degrees.z += rot_value * 50.0;
	mass = MASS + absf(rotation_degrees.z)
	#rotation_degrees.z = move_toward(rotation_degrees.z, 0, delta*150.0)
	#rotation_degrees.x = move_toward(rotation_degrees.x, 0, delta*150.0)
	rotate_y(rot_value);
	tilt_delta += Input.get_axis("left", "right")*delta*0.5
	if (tilt_delta == 0):
		horse_tilt = move_toward(horse_tilt, 0.0, delta*2)
	horse_tilt += tilt_delta
	model.rotation.z = horse_tilt
	if (horse_tilt < -0.5*PI):
		horse_tilt = -0.5*PI
	elif (horse_tilt > 0.5*PI):
		horse_tilt = 0.5*PI
		

	
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
		

