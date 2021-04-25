extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 15 
var fallspeed = 500
var speed = 500 
var jump = -700
var accel = 20

var motion = Vector2()

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	motion.y += GRAVITY
	if motion.y > fallspeed:
		motion.y = fallspeed
	
	motion.x = clamp(motion.x,-speed, speed)
	
	if Input.is_action_pressed("left"):
		motion.x -= accel
	elif Input.is_action_pressed("right"):
		motion.x += accel
	elif is_on_floor():
		motion.x = lerp(motion.x,0,0.075)
	else:
		motion.x = lerp(motion.x,0,0.01)
	
	if Input.is_action_just_pressed("jump"):
		if is_on_wall() or is_on_floor():
			motion.y = jump
	
	motion = move_and_slide(motion,UP)
