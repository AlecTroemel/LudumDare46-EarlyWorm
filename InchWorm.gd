extends Node2D

var state = "normal"
var last_note_played = null

func play_note():
	var note = randi() % 5
	if note == last_note_played:
		note = (note + 1) % 5
	last_note_played = note
	
	if note == 0:
		$AudioG.play()
	if note == 1:
		$AudioA.play()
	if note == 2:
		$AudioB.play()
	if note == 3:
		$AudioC.play()
	if note == 4:
		$AudioD.play()

func process_body(body: Node2D, dist, anchor, u, i, grow_max, grow_scale):
	body.position =  $Butt.position + (dist * 0.143 * i * u)
	var dist_from_anchor = body.position.distance_to(anchor.position) / 2
	body.grow = max((grow_max - dist_from_anchor) * grow_scale, 0)
	body.update()
	
func place_body():
	var dist = $Head.position.distance_to($Butt.position)
	var u = ($Head.position - $Butt.position).normalized()

	process_body($Body,dist,$Butt,u,1,0,1)
	process_body($Body2,dist,$Butt,u,2,30,0.80)
	process_body($Body3,dist,$Butt,u,3,45,1)
	process_body($Body4,dist,$Head,u,4,45,1)
	process_body($Body5,dist,$Head,u,5,30,0.80)
	process_body($Body6,dist,$Head,u,6,10,1)
	
	if dist < 190:
		$Head.z_index = 1
		$Body.z_index = 2
		$Body2.z_index = 3
		$Body3.z_index = 4
		$Body4.z_index = 4
		$Body5.z_index = 3
		$Body6.z_index = 2
	else:
		$Head.z_index = 1
		$Body.z_index = 2
		$Body2.z_index = 2
		$Body3.z_index = 2
		$Body4.z_index = 2
		$Body5.z_index = 2
		$Body6.z_index = 2
	
	if dist > 210 and state != "stretched":
		state = "stretched"
		play_note()
	elif dist < 175 and state != "scrunched":
		state = "scrunched"
		play_note()
	
	
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
	
	$Area2D.position = $Head.position
	
#func _physics_process(delta):
#	if Input.is_action_just_pressed("ui_accept"):


