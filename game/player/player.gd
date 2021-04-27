extends KinematicBody

export var speed : float = 25
export var accel : float = 10
export var air_accel : float = 5
export var gravity : float = 0.5
export var terminal_velocity : float = 54
export var jump : float = 25

export var mouse_sens : float = 0.3

var velocity : Vector3
var y_velocity : float

onready var cambase = $cambase
onready var cam = $cambase/spring/cam

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event is InputEventMouseMotion:
		cambase.rotation_degrees.y -= event.relative.x * mouse_sens
		cambase.rotation_degrees.x -= event.relative.y * mouse_sens
		cambase.rotation_degrees.x = clamp(cambase.rotation_degrees.x, -60, 60)

func _physics_process(delta):
	movement(delta)

func movement(delta):
	var direction = Vector3()
	
	if Input.is_action_pressed("forewards"):
		direction -= cambase.transform.basis.z
	
	if Input.is_action_pressed("backwards"):
		direction += cambase.transform.basis.z
		
	if Input.is_action_pressed("left"):
		direction -= cambase.transform.basis.x
	
	if Input.is_action_pressed("right"):
		direction += cambase.transform.basis.x
	
	direction = direction.normalized()
	
	var bruh = accel if is_on_floor() else air_accel
	velocity = velocity.linear_interpolate(direction * speed, bruh * delta)
	if is_on_floor():
		y_velocity = -0.01
	else:
		y_velocity = clamp(y_velocity - gravity, -terminal_velocity, terminal_velocity)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		y_velocity = jump
	
	velocity.y = y_velocity
	velocity = move_and_slide(velocity, Vector3.UP)
