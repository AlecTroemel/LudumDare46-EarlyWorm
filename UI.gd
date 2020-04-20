extends MarginContainer

var messages = ["I hunger", "Worm flesh, now!", "Feed me worm", "I need more worm!"]

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
	$Hunger/Panel/VBoxContainer/MarginContainer/Label.text = messages[0]
	$MessageTimer.start()
	var tween = get_node("Tween")
	tween.interpolate_property($Hunger, "modulate:a",
		0, 1, 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")

func update_hunger(h):
	$Hunger/Panel/VBoxContainer/Bar/TextureProgress.value = h

func _on_MessageTimer_timeout():
	var tween = get_node("Tween")
	tween.interpolate_property($Hunger/Panel/VBoxContainer/MarginContainer/Label, "modulate:a",
		1, 0, 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	
	var i = randi() % len(messages)
	if messages[i] == $Hunger/Panel/VBoxContainer/MarginContainer/Label.text:
		i = (i+1) % len(messages)
	$Hunger/Panel/VBoxContainer/MarginContainer/Label.text = "\"%s\"" % messages[i]
	
	tween.interpolate_property($Hunger/Panel/VBoxContainer/MarginContainer/Label, "modulate:a",
		0, 1, 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
