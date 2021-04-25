extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 15 

var motion = Vector2()

var player = {
	"name" : "none",
	"traits" : ["SillyTrait","SillyTrait2"],
	"BaseStats" : [5,5,5,5,5,5]
}

var weight = player.get("BaseStats")[0] * player.get("BaseStats")[1]
var speed = player.get("BaseStats")[5]
var accel = player.get("BaseStats")[5] - weight
var jump = player.get("BaseStats")[5] - weight

func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	
	motion.y += GRAVITY
	if motion.y > weight:
		motion.y = weight
	
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
