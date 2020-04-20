extends Node2D

var target: Node2D
var target_pos: Vector2

var max_range = 150
var max_speed = 500

var level_bounds = null;

func _ready():
	$Camera.make_current()


# follow a Node around
# smoothly
func follow(node):
	target = node

# smoothly move to an exact position
# while also breaking away from the
# target
func center(pos):
	target = null
	target_pos = pos
	
# snap camera to a location
# clears node target
func teleport(pos):
	target = null;
	self.position = pos
	
func confine(bounds: Dictionary):
	if bounds and bounds.keys():
		level_bounds = bounds
	else:
		level_bounds = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		var current_pos = target.global_position
		var dist = target_pos.distance_to(current_pos)
		
		if dist > max_range:
			target_pos = current_pos
	
	var remaining = self.position.distance_to(target_pos)
	var speed = min(remaining * 2.0, max_speed) * delta
	
	self.position = self.position.move_toward(target_pos, speed)
	
	if level_bounds:
		var horiz = get_viewport_rect().size.x / 2
		var vert = get_viewport_rect().size.y / 2
		
		var left = level_bounds.get('left', null)
		var right = level_bounds.get('right', null)
		var top = level_bounds.get('top', null)
		var bottom = level_bounds.get('bottom', null)
		
		if left and self.position.x - horiz < left:
			self.position.x = left + horiz
		if right and self.position.x + horiz > right:
			self.position.x = right - horiz
		if top and self.position.y + vert < top:
			self.position.y = top - vert
		if top and self.position.y - vert > top:
			self.position.y = bottom + vert
	
	#self.position = self.position.move_toward(target_pos, max_speed * delta)


func _on_camera_target(Node2d):
	pass # Replace with function body.
