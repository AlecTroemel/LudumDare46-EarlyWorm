extends MarginContainer

func hide_tutorial():
	var tween = get_node("Tween")
	tween.interpolate_property($VBoxContainer/Instruction, "modulate:a",
		1, 0, 0.4,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	return true
	
func show_title():
	var tween = get_node("Tween")
	tween.interpolate_property($VBoxContainer/Title, "modulate:a",
		0, 0.9, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")

func hide_title():
	var tween = get_node("Tween")
	tween.interpolate_property($VBoxContainer/Title, "modulate:a",
		0.9, 0, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")

func show_hunger():
	var tween = get_node("Tween")
	tween.interpolate_property($Hunger, "modulate:a",
		0, 1, 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")

func update_hunger(h):
	$Hunger/HBoxContainer/Bar/TextureProgress.value = h
