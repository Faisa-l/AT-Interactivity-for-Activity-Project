class_name WalkingTracker extends Node

# Tracks walking
# Currently will emulate how this is likely to pick up the walking information from the phone

@export
var travelling_speed : float = 1.0

var distance_travelled : float
var running : bool:
	get: return !timer.is_stopped()

# Timeout will be when a distance is travelled
@onready
var timer : Timer = $Timer

# Starts the tracker
func start():
	timer.start()

# Pauses the tracker
func pause():
	timer.stop()

# Resets the tracker
func reset():
	timer.stop()
	distance_travelled = 0.0

# Timeout will be when a distance has been travelled
func _on_timer_timeout() -> void:
	distance_travelled += travelling_speed
