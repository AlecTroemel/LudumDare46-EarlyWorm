extends Control

func hide_tutorial():
	var tween = get_node("Tween")
	tween.interpolate_property($Instruction, "modulate:a",
		1, 0, 0.4,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	return true
	
func show_title():
	var tween = get_node("Tween")
	tween.interpolate_property($Title, "modulate:a",
		0, 0.9, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")

func hide_title():
	var tween = get_node("Tween")
	tween.interpolate_property($Title, "modulate:a",
		0.9, 0, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
