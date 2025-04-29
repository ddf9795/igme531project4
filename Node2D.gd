extends Node2D

export (Gradient) var gradient

const VU_COUNT = 1024
const FREQ_MAX = 11050.0

const BALL_COUNT = 175

var WIDTH = 5000
const HEIGHT = 100

const MIN_DB = 1

var spectrum


func _ready():
#	WIDTH = OS.get_window_safe_area().size.x
	spectrum = AudioServer.get_bus_effect_instance(1,0)
	var prev_hz = 0
	for i in range(1, VU_COUNT+1):
		var bar = preload("res://Bar.tscn").instance()
		get_tree().get_root().call_deferred("add_child", bar)
		bar.color = gradient.interpolate(i / float(VU_COUNT+1))
		bar.position.x = i
		bar.position.y = 600
		var hz = i * FREQ_MAX / VU_COUNT;
		bar.spectrum = spectrum
		bar.hz = hz
		bar.prev_hz = prev_hz
		prev_hz = hz
	for i in range(BALL_COUNT):
		var ball = preload("res://Ball.tscn").instance()
		get_tree().get_root().call_deferred("add_child", ball)
		ball.position.x = rand_range(0, OS.get_window_safe_area().size.x)
		ball.position.y = 10


func _process(_delta):
	update()


#func _draw():
#	#warning-ignore:integer_division
#	var w = WIDTH / VU_COUNT
#	var prev_hz = 0
#	for i in range(1, VU_COUNT+1):
#		var hz = i * FREQ_MAX / VU_COUNT;
#		var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
#		var energy = clamp((MIN_DB + linear2db(magnitude)) / MIN_DB, 0, 1)
#		var height = energy * HEIGHT
#		draw_rect(Rect2(w * i, HEIGHT - height, w, height), Color.white)
#		prev_hz = hz
