extends Node2D

export (Color) var color = null 
export (int) var radius = 15
export (int) var grow = 0

func _draw():
	draw_circle(Vector2(0,0), radius + grow, color)

func _ready():
	$StaticBody2D/CollisionShape2D.shape.radius = radius
