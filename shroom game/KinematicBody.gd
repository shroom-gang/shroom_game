extends KinematicBody

var gravity = Vector3.DOWN * 12
var speed = 50
var accel = 20
var jump_power = 6

var velocity = Vector3()

func _physics_process(delta):
	velocity += gravity * delta
	velocity = move_and_slide(velocity, Vector3.UP)
	
	if Input.is_action_pressed("forewards"):
			velocity = -transform.basis.z * accel 
	if Input.is_action_pressed("backwards"):
			velocity = transform.basis.z * accel 
	if Input.is_action_pressed("left"):
			rotation_degrees.y += 2
	if Input.is_action_pressed("right"):
			rotation_degrees.y -= 2

#func _unhandled_input(event):
#	if event is InputEventMouseMotion:
	
