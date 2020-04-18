extends Node2D

func place_body():
	var dist = $Head.position.distance_to($Butt.position)
	var u = ($Head.position - $Butt.position).normalized()
	
	$Body.position =  $Butt.position + (dist * 0.2 * u)
	$Body2.position =  $Butt.position + (dist * 0.4 * u)
	$Body3.position =  $Butt.position + (dist * 0.6 * u)
	$Body4.position =  $Butt.position + (dist * 0.8 * u)
	
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
	
	place_body()
#func _physics_process(delta):
#	if Input.is_action_just_pressed("ui_accept"):

