extends Node2D

var clicking = false

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			get_tree().quit()
	if event is InputEventMouse:
		if event.button_mask == BUTTON_MASK_LEFT:
			if not clicking:
				var impulse = preload("res://ClickSphere.tscn").instance()
				get_tree().get_root().call_deferred("add_child", impulse)
				impulse.position = event.position
			clicking = true
		else:
			clicking = false
