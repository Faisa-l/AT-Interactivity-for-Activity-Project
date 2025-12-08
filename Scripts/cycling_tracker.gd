class_name CyclingTracker extends ActivityTracker

@export
var speed : float = 1.0

@onready
var timer : Timer = $Timer

var distance : float = 0.0

func start():
	timer.start()

func pause():
	timer.stop()

func reset():
	timer.stop()
	distance = 0

func end():
	reset()



func _on_timer_timeout() -> void:
	distance += speed
	result = distance
