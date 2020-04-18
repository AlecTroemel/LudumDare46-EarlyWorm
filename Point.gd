extends RigidBody2D

export (Color) var color = null 
export (int) var radius = 10

func _process(delta):
	if self.mode != 0:
		return

	if Input.is_action_pressed('ui_right'):
		apply_impulse(Vector2(0,0), Vector2(10,0))
	if Input.is_action_pressed('ui_left'):
		apply_impulse(Vector2(0,0), Vector2(-10,0))
	if Input.is_action_pressed('ui_down'):
		apply_impulse(Vector2(0,0), Vector2(0,10))
	if Input.is_action_pressed('ui_up'):
		apply_impulse(Vector2(0,0), Vector2(0,-10))

func _draw():
	draw_circle(Vector2(0,0), radius, color)
