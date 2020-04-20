extends RigidBody2D

var reset_physics = false
var reset = true
var starting_pos = Vector2.ZERO
var starting_mode = 0
var starting_rotation = 0
var controlable = true

func _process(delta):
	if self.mode != 0:
		return
	
	if reset and not reset_physics:
		set_mode(starting_mode)
		reset = false
	
	if not controlable:
		return
#
	if Input.is_action_pressed('ui_right'):
		apply_impulse(Vector2(0,0), Vector2(10,0))
	if Input.is_action_pressed('ui_left'):
		apply_impulse(Vector2(0,0), Vector2(-10,0))
	if Input.is_action_pressed('ui_down'):
		apply_impulse(Vector2(0,0), Vector2(0,10))
	if Input.is_action_pressed('ui_up'):
		apply_impulse(Vector2(0,0), Vector2(0,-10))

func _integrate_forces(state):
	if reset_physics:
		state.transform = Transform2D(starting_rotation, starting_pos)
		state.linear_velocity = Vector2()
		state.angular_velocity = 0

		reset_physics = false

		
func reset(pos, m, rot):
	starting_pos = pos
	starting_mode = m
	starting_rotation = rot
	reset_physics = true
	reset = true 
