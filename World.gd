extends Node2D

var first_time = true
var levels = ["Level0", "Level1"]
var current_level = null

func _ready():
	current_level = 0
	load_level(0)

func _on_Bird_area_entered(area):
	if first_time:
		$BGMusic.play()
		$UIZ/UI.hide_tutorial()
		yield($UIZ/UI/Tween, "tween_completed")
		$UIZ/UI.show_title()
		yield($UIZ/UI/Tween, "tween_completed")
		$Timer.start()
		yield($Timer, "timeout")
		first_time = false
	progress_level()

func progress_level():
	fade_screen()
	yield($Tween, "tween_completed")
	
	$UIZ/UI.hide_title()
	
	current_level += 1
	load_level(current_level)
	$Timer2.start()
	yield($Timer2, "timeout")
	fadent_screen()
	yield($Tween, "tween_completed")

func fade_screen():
	var tween = get_node("Tween")
	tween.interpolate_property($Wipe, "modulate:a",
		0, 1, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")

func fadent_screen():
	var tween = get_node("Tween")
	tween.interpolate_property($Wipe, "modulate:a",
		1, 0, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield (tween, "tween_completed")
	

func load_level(i):
	if current_level > 0:
		get_node("%s" % levels[current_level-1]).queue_free()
	var filepath = "res://Level/%s.tscn" % levels[i]
	var level_resource = load(filepath)
	var level = level_resource.instance()
	add_child(level)
	$InchWorm.teleport(level.worm_position)
	$InchWorm.rotation_degrees = level.worm_rotation
	$Bird.position = level.bird_position
	
	
	# move camera to the bird, then transition
	# smoothly to worm
	$CameraRig.teleport(level.bird_position)
	$CameraRig.follow($InchWorm.get_node('Body3'))
	
	
