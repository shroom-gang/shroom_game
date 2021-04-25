extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 15 

var player = {
	"name" : "none",
	"traits" : ["SillyTrait","SillyTrait2"],
	"BaseStats" : [1,1,1,1,1,1]
}

var weight = player.get("BaseStats")[0] * player.get("BaseStats")[1]
var fallspeed = 500 + (weight * 20)
var speed = 300 + (100 * player.get("BaseStats")[5])
var jump = 500 + (100 * player.get("BaseStats")[5])
var accel = 20 + player.get("BaseStats")[5] - (weight * 0.2)

var motion = Vector2()

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
			motion.y = -jump
	
	motion = move_and_slide(motion,UP)
