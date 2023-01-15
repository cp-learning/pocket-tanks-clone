class_name Player
extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const WALK_ACCEL = 500.0
const WALK_DEACCEL = 1000.0
const WALK_MAX_VELOCITY = 140.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _integrate_forces(state):
	var linear_velocity = state.get_linear_velocity()
	var step = state.get_step()
	
	var move_left = Input.is_action_pressed("ui_left")
	var move_right = Input.is_action_pressed("ui_right")

	if move_left and not move_right:
		if linear_velocity.x > -WALK_MAX_VELOCITY:
			linear_velocity.x -= WALK_ACCEL * step
	elif move_right and not move_left:
		if linear_velocity.x < WALK_MAX_VELOCITY:
			linear_velocity.x += WALK_ACCEL * step
	else:
		var xv = abs(linear_velocity.x)
		xv -= WALK_DEACCEL * step
		if xv < 0:
			xv = 0
		linear_velocity.x = sign(linear_velocity.x) * xv
			
	linear_velocity += state.get_total_gravity() * step
	state.set_linear_velocity(linear_velocity)
	
	
