extends Node2D

var timer = 0

func _physics_process(delta):
	timer += delta
	if timer >= 1.0:
		queue_free()

func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is RigidBody2D:
		if "timer" in body:
			body.timer = body.TIMER_MAX
			body.set_axis_velocity(Vector2.ZERO)
			var dir = to_global(body.position) - to_global(position)
			body.apply_central_impulse(dir * 15.0)
#			body.shape.set_deferred("disabled", true)
