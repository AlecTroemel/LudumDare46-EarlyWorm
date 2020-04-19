extends Node2D

var target: Node2D

var last_pos: Vector2
var target_pos: Vector2

var max_range = 150
var max_speed = 400


func _ready():
	$Camera.make_current()


# follow a Node around
# smoothly
func follow(node):
	last_pos = self.position
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		var current_pos = target.global_position
		var dist = target_pos.distance_to(current_pos)
		
		if dist > max_range:
			last_pos = self.position
			target_pos = current_pos
			
	self.position = self.position.move_toward(target_pos, max_speed * delta)
		
		
		# self.position = self.target.global_position


func _on_camera_target(Node2d):
	pass # Replace with function body.
