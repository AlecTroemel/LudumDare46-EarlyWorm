extends Node2D

var first_time = true
var levels = ["Level0", "Level1", "Level2", "Level3", "Level4","Level5", "End"]
var current_level = null
var old_level = null
var hunger = 100
var max_hunger = 100
var loading = false
	
func _ready():
	hunger = max_hunger
	load_level(0)

func _on_Bird_area_entered(area):
	if loading:
		return
	loading = true
	$InchWorm.stop_controls()
	if first_time:
		$BGMusic.play()
		$UIZ/UI.hide_tutorial()
		yield($UIZ/UI/Tween, "tween_completed")
		$UIZ/UI.show_title()
		yield($UIZ/UI/Tween, "tween_completed")
		$Timer.start()
		yield($Timer, "timeout")
		first_time = false
		$UIZ/UI.show_hunger()
		
	progress_level()

func progress_level():
	fade_screen()
	yield($Tween, "tween_completed")
	
	$UIZ/UI.hide_title()

	hunger = max_hunger
	
	load_level(current_level+1)
	$Timer2.start()
	yield($Timer2, "timeout")
	fadent_screen()
	yield($Tween, "tween_completed")
	$InchWorm.start_controls()
	loading = false

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
	if current_level != null:
		get_node("%s" % levels[current_level]).queue_free()
	var filepath = "res://Level/%s.tscn" % levels[i]
	var level_resource = load(filepath)
	var level = level_resource.instance()
	
	$InchWorm.teleport(level.worm_position, level.worm_butt_position)
	$Bird.position = level.bird_position
	$Bird.emote(hunger)
	if level.ending == true:
		game_won() 
		
	# move camera to the bird, then transition
	# smoothly to worm
	$CameraRig.teleport(level.bird_position)
	$CameraRig.follow($InchWorm.get_node('Body3'))
	$CameraRig.confine(level.camera_limit)
	
	add_child(level)
	current_level = i

func _on_HungerTimer_timeout():
	if first_time:
		return 
	
	hunger -= 1
	$UIZ/UI.update_hunger(hunger)
	$Bird.emote(hunger)
	if hunger < 1:
		game_over()
		 
func game_over():
	first_time = true
	hunger = max_hunger
	load_level(0)
	current_level = 0
	
	$BGMusic.stop()
	$UIZ/UI.show_tutorial()
	$UIZ/UI.hide_hunger()
	
func game_won():
	$HungerTimer.stop()
