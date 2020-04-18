extends Node2D

export (Color) var color = null 
export (int) var radius = 10

func _draw():
	draw_circle(Vector2(0,0), radius, color)
