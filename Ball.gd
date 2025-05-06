extends RigidBody2D

var is_ball = true

onready var shape = $CollisionShape2D

export (Gradient) var gradient

var timer = 0
const TIMER_MAX = 0.1

var bodies = []

func _process(delta):
	modulate = gradient.interpolate(bodies.size() / 175.0)

func _physics_process(delta):
	var _max = 0
	for body in bodies:
		if _max > 20:
			break
		var dir = Vector2(position.x - body.get_parent().position.x, position.y - body.get_parent().position.y).normalized()
		apply_central_impulse(-dir * 1.5)
		_max += 1
	if position.y < 0:
		position.y = 0
		set_axis_velocity(Vector2(0, 1))
	if position.y >= 600:
#		position.y -= 600
		position.y = 590
		set_axis_velocity(Vector2(0, -linear_velocity.y - 10))
#	if position.x > OS.get_window_safe_area().size.x:
	if position.x > 1024:
		position.x -= 1024
	if position.x < 0:
		position.x += 1024
	if linear_velocity.x < -98.0:
		set_axis_velocity(Vector2(-98.0, linear_velocity.y))
	if linear_velocity.x > 98.0:
		set_axis_velocity(Vector2(98.0, linear_velocity.y))
#	if linear_velocity.y < -250.0:
#		set_axis_velocity(Vector2(linear_velocity.x, -250.0))
#	if linear_velocity.y > 250.0:
#		set_axis_velocity(Vector2(linear_velocity.x, 250.0))
#	print(position.y)
#	if timer > 0:
#		timer -= delta
#		if timer <= 0:
#			timer = 0
#			shape.set_deferred("disabled", false)


func _on_Area2D_area_entered(area):
	if area is Area2D:
		if "is_ball" in area.get_parent():
			if not area in bodies:
				bodies.push_back(area)


func _on_Area2D_area_exited(area):
	if area is Area2D:
		if "is_ball" in area.get_parent():
			var i = 0
			for b in bodies:
				if area == b:
					bodies.pop_at(i)
					return
				i += 1
