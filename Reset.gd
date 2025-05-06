extends Node2D

var timer = 0.0

func _process(delta):
	timer += delta
	if timer >= 1.0:
		get_tree().change_scene("res://Main.tscn")
