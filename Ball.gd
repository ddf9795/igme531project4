extends RigidBody2D

onready var shape = $CollisionShape2D

export (Gradient) var gradient

var timer = 0
const TIMER_MAX = 0.1

var bodies = []

func _process(delta):
	modulate = gradient.interpolate(bodies.size() / 175.0)

func _physics_process(delta):
	for body in bodies:
		var dir = Vector2(position.x - body.get_parent().position.x, position.y - body.get_parent().position.y).normalized()
		apply_central_impulse(-dir * 1.5)
	if position.y < 0:
		position.y = 0
		set_axis_velocity(Vector2(0, 1))
	if position.y >= 600:
		position.y -= 600
	if position.x > OS.get_window_safe_area().size.x:
		position.x -= OS.get_window_safe_area().size.x
	if position.x < 0:
		position.x += OS.get_window_safe_area().size.x
#	print(position.y)
#	if timer > 0:
#		timer -= delta
#		if timer <= 0:
#			timer = 0
#			shape.set_deferred("disabled", false)


func _on_Area2D_area_entered(area):
	if area is Area2D:
		if not area in bodies:
			bodies.push_back(area)


func _on_Area2D_area_exited(area):
	if area is Area2D:
		var i = 0
		for b in bodies:
			if area == b:
				bodies.pop_at(i)
				return
			i += 1
