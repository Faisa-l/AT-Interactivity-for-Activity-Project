extends Control

@onready
var event_creator : EventCreator = $EventCreator

@onready
var activity_scheduler : ActivityScheduler = $ActivityTracking/ActivityScheduler

@onready
var walking_tracker : WalkingTracker = $ActivityTracking/WalkingTracker

@onready
var notification_list : VBoxContainer = $ActivityNotifications

@onready
var user_pet : UserPet = $UserPet

@onready
var notification_scene : PackedScene = load("res://Scenes/displayed_activity_notification.tscn")

var notification_pairs : Dictionary[String, DisplayedActivityNotification]

func _ready() -> void:
	event_creator.event_submitted.connect(on_event_submitted)
	activity_scheduler.event_started.connect(process_event_started)
	activity_scheduler.event_ended.connect(process_event_ended)
	activity_scheduler.event_running.connect(process_event_running)

func on_event_submitted(hours: int, minutes: int, activity : String, duration : int, title : String) -> void:
	# Convert to dictionary
	var time : Dictionary = Time.get_datetime_dict_from_system()
	time["hour"] = hours
	time["minute"] = minutes
	
	var success = activity_scheduler.schedule_activity(activity, time, duration, title)
	if success:
		var card : DisplayedActivityNotification = notification_scene.instantiate()
		notification_list.add_child(card)
		card.initialise(success)
		notification_pairs[activity] = card

# When a scheduled event starts, start the corresponding tracker
func process_event_started(event: ScheduledActivity) -> void:
	if event.activity == "Walking":
		walking_tracker.reset()
		walking_tracker.start()

# When a scheduled event ends, stop the corresponding tracker
func process_event_ended(event: ScheduledActivity) -> void:
	if event.activity == "Walking":
		walking_tracker.pause()
		print("Walked distance: " + str(walking_tracker.distance_travelled))
		user_pet.on_event_ended(event)
		notification_pairs[event.activity].queue_free()

# When a scheduled event is running, perform its tracker thing
func process_event_running(event: ScheduledActivity) -> void:
	if event.activity == "Walking":
		event.result = walking_tracker.distance_travelled
		notification_pairs["Walking"].activity_value_label.text = str(event.result)
		# user_pet.on_event_ended(event)

#region debug

# Debug function to end the event immediately
func force_end_event() -> void:
	if activity_scheduler.current_event:
		activity_scheduler.event_ended.emit(activity_scheduler.current_event)

# For debug
func _on_end_event_button_button_up() -> void:
	force_end_event()

#endregion
