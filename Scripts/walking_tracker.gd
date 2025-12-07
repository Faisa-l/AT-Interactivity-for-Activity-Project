class_name WalkingTracker extends ActivityTracker

# Tracks walking
# Currently will emulate how this is likely to pick up the walking information from the phone

@export
var travelling_speed : float = 1.0


# Timeout will be when a distance is travelled
@onready
var timer : Timer = $Timer

@onready
var android_step_counter : AndriodStepTracker = $AndroidStepTracker

var distance_travelled : float
var running : bool:
	get: return !timer.is_stopped()

# Starts the tracker
func start():
	timer.start()
	
	if android_step_counter.valid:
		
		if !android_step_counter.started_service: 
			android_step_counter.initialise_service()
		
		android_step_counter.enable_sensors = true

# Pauses the tracker
func pause():
	timer.stop()
	android_step_counter.enable_sensors = false
	
	if android_step_counter.valid:
		android_step_counter.end_step_counter()

# Resets the tracker
func reset():
	timer.stop()
	distance_travelled = 0.0
	
	if android_step_counter.valid:
		android_step_counter.reset_step_counter()

# Ends the counter
func end():
	pause()
	reset()
	if android_step_counter.valid:
		android_step_counter.end_service()

# Timeout will be when a distance has been travelled
func _on_timer_timeout() -> void:
	distance_travelled += travelling_speed
	
	if android_step_counter.valid:
		print(android_step_counter.step_data)
		result = android_step_counter.step_data["steps"] if android_step_counter.step_data.size() != 0 else result
	else:
		result = distance_travelled
