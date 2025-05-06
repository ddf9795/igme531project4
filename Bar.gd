extends Node2D

onready var visual = $Visual

export (Gradient) var gradient

var color = Color.white

var prev_hz = 0
var hz = 0
var prev_vel = 0
var vel = 0

#const VU_COUNT = 1024
#const FREQ_MAX = 44100.0

#var WIDTH = 5000
const HEIGHT = 200

const MIN_DB = 60

var spectrum


#func _ready():
#	WIDTH = OS.get_window_safe_area().size.x
#	spectrum = AudioServer.get_bus_effect_instance(0,0)


func _process(_delta):
	visual.modulate = color
	var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
	vel = abs(magnitude - prev_vel)
	var energy = clamp((MIN_DB + linear2db(magnitude)) / MIN_DB, 0, 1)
	var height = energy * HEIGHT + 20
	$Visual.rect_scale = $Visual.rect_scale.linear_interpolate(Vector2($Visual.rect_scale.x, -height), 0.3)
#	$"%Collision".shape.set_extents(Vector2(0.78, -$Visual.rect_scale.y))
	$"%Collision".position.y = $Visual.rect_scale.y + 600
	modulate = gradient.interpolate(energy)
	prev_vel = vel


func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is RigidBody2D:
		if "timer" in body:
			body.timer = body.TIMER_MAX
			body.set_axis_velocity(Vector2.ZERO)
			body.apply_central_impulse(Vector2(0, -vel - 5 * body.weight))
#			body.shape.set_deferred("disabled", true)
