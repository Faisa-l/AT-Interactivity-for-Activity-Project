extends Control

@onready
var event_creator : EventCreator = $EventCreator

@onready
var activity_scheduler : ActivityScheduler = $ActivityTracking/ActivityScheduler

@onready
var walking_tracker : WalkingTracker = $ActivityTracking/WalkingTracker

func _ready() -> void:
	event_creator.event_submitted.connect(on_event_submitted)
	activity_scheduler.event_started.connect(process_event_started)
	activity_scheduler.event_ended.connect(process_event_ended)

func on_event_submitted(hours: int, minutes: int, activity : String) -> void:
	# Convert to dictionary
	var time : Dictionary = Time.get_datetime_dict_from_system()
	time["hour"] = hours
	time["minute"] = minutes
	
	activity_scheduler.schedule_activity(activity, time, 30)

# When a scheduled event starts, start the corresponding tracker
func process_event_started(activity: String) -> void:
	if activity == "Walking":
		walking_tracker.reset()
		walking_tracker.start()

# When a scheduled event ends, stop the corresponding tracker
func process_event_ended(activity: String) -> void:
	if activity == "Walking":
		walking_tracker.pause()
		print("Walked distance: " + str(walking_tracker.distance_travelled))
