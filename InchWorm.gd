extends Node2D

func _ready():
	$Line2D.add_point($Head.position)
	$Line2D.add_point($Butt.position)

	$Head.mode=1
	$Butt.mode=0

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_SPACE:
			if event.is_pressed() == true:
				$Head.mode=0
				$Butt.mode=1
			else:
				$Head.mode=1
				$Butt.mode=0

func _process(delta):
	$Line2D.points[0] = $Head.position
	$Line2D.points[1] = $Butt.position
	
	$SpringJoint.position = $Head.position
	$SpringJoint.look_at($Butt.position)
	
	$SpringJoint2.position = $Butt.position
	$SpringJoint2.look_at($Head.position)
	
#func _physics_process(delta):
#	if Input.is_action_just_pressed("ui_accept"):

