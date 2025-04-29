extends Node2D

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			get_tree().quit()
