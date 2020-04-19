extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal area_entered(area)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	emit_signal("area_entered", area)
	pass # Replace with function body.
