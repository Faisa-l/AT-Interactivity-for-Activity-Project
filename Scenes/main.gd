extends Control

@onready
var event_creator : EventCreator = $EventCreator

@onready
var activity_scheduler : ActivityScheduler = $ActivityTracking/ActivityScheduler

func _ready() -> void:
	event_creator.event_submitted.connect(on_event_submitted)

func on_event_submitted(hours: int, minutes: int, activity : String):
	# Convert to dictionary
	var time : Dictionary = Time.get_datetime_dict_from_system()
	time["hour"] = hours
	time["minute"] = minutes
	
	activity_scheduler.schedule_activity(activity, time, 30)
	
	pass
