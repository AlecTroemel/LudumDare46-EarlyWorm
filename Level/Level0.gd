extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Bird_area_entered(area):
	var tween = get_node("Tween")
	tween.interpolate_property($Title, "modulate:a",
		0, 0.9, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	tween.interpolate_property($Instruction, "modulate:a",
		1, 0, 0.4,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	tween.interpolate_property($World, "position:y",
		0, 1100, 5,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()
	
	tween.interpolate_property($World/InchWorm, "modulate:a",
		1, 0, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
