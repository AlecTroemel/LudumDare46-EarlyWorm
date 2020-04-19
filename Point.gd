extends RigidBody2D

var reset_physics = false
var reset = true
var starting_pos = Vector2.ZERO
var starting_mode = 0

func _process(delta):
	if self.mode != 0:
		return
	
	if reset and not reset_physics:
		set_mode(starting_mode)
		reset = false
	
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
		state.transform = Transform2D(0, starting_pos)
		reset_physics = false

		
func reset(pos, m):
	starting_pos = pos
	starting_mode = m
	reset_physics = true
	reset = true 
