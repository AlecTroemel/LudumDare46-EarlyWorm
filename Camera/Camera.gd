extends Node2D

var target: Node2D

var last_pos: Vector2
var target_pos: Vector2

var max_range = 150
var max_speed = 500

var journey = 0
var journey_speed = 0.1


func _ready():
	$Camera.make_current()


# follow a Node around
# smoothly
func follow(node):
	last_pos = self.position
	journey = 0
	target = node

# smoothly move to an exact position
# while also breaking away from the
# target
func center(pos):
	target = null
	target_pos = pos
	journey = 0
	
# snap camera to a location
# clears node target
func teleport(pos):
	target = null;
	self.position = pos
	journey = 0
	
func boundaries(top, bottom, left, right):
	#var collider = shape.get_node('CameraShape')
	#collider.
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		var current_pos = target.global_position
		var dist = target_pos.distance_to(current_pos)
		
		if dist > max_range:
			last_pos = self.position
			target_pos = current_pos
#			journey = 0.0
	
#	if journey < 1.0:
#		journey = min(1.0, journey + (journey_speed * delta))
#		
#		# applaud my supreme power
#		var progress = (1 - cos(journey * PI))/2
#		self.position = last_pos.linear_interpolate(target_pos, progress)
	
	var remaining = self.position.distance_to(target_pos)
	var speed = min(remaining * 2.0, max_speed) * delta
	
	self.position = self.position.move_toward(target_pos, speed)
	
	#self.position = self.position.move_toward(target_pos, max_speed * delta)


func _on_camera_target(Node2d):
	pass # Replace with function body.
