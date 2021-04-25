extends KinematicBody

const GRAVITY = 0.98
const HLOOK = 0.5
const VLOOK = 0.5

var maxspeed = 100
var acceleration = 300
var jump = 30
var fallspeed = 30
var y_velo = 0

onready var cam = $CamBase
onready var anim = $Graphics/AnimationPlayer

func _input(event):
	if event is InputEventMouseMotion:
		cam.rotation_degrees.x -= event.relative.y * VLOOK
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x, -70, 70)
		cam.rotation_degrees.y -= event.relative.x * HLOOK
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	var move_vec = Vector3()
	
	if Input.is_action_pressed("forewards"):
		move_vec.z -= maxspeed
	if Input.is_action_pressed("back"):
		move_vec.z += maxspeed
	if Input.is_action_pressed("right"):
		rotation_degrees.y = -maxspeed
	if Input.is_action_pressed("left"):
		rotation_degrees.y = maxspeed
	
	move_vec = move_vec.normalized()
	move_vec.y = y_velo
	move_and_slide(move_vec, Vector3(0, 1, 0))
	
	var grounded = is_on_floor()
	y_velo -= GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		y_velo = jump
	if grounded and y_velo <= 0:
		y_velo = -0.1
	if y_velo < -fallspeed:
		y_velo = -fallspeed
