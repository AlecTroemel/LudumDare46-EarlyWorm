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

func emote(hunger):
	if hunger <= 0:
		pass
	if hunger < 30:
		if $AnimationPlayer.current_animation != 'starving':
			$AnimationPlayer.play("starving")
	elif hunger < 60:
		if $AnimationPlayer.current_animation != 'hungry':
			$AnimationPlayer.play("hungry")
	elif hunger >= 60:
		if $AnimationPlayer.current_animation != 'happy':
			$AnimationPlayer.play("happy")


func _on_Area2D_area_entered(area):
	$Bite.play()
	$AnimationPlayer.play("consume")
	emit_signal("area_entered", area)
