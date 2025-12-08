extends Control

@onready
var event_creator : EventCreator = $EventCreator

@onready
var activity_scheduler : ActivityScheduler = $ActivityTracking/ActivityScheduler

@onready
var walking_tracker : WalkingTracker = $ActivityTracking/WalkingTracker

@onready
var cycling_tracker : CyclingTracker = $ActivityTracking/CyclingTracker

@onready
var notification_list : VBoxContainer = $ActivityNotifications

@onready
var friends_list : FriendsList = $FriendsList

@onready
var user_pet : UserPet = $UserPet

@onready
var notification_scene : PackedScene = load("res://Scenes/displayed_activity_notification.tscn")

var notification_pairs : Dictionary[String, DisplayedActivityNotification]
var trackers : Dictionary[Enums.ActivityType, ActivityTracker]

func _ready() -> void:
	event_creator.event_submitted.connect(on_event_submitted)
	activity_scheduler.event_started.connect(process_event_started)
	activity_scheduler.event_ended.connect(process_event_ended)
	activity_scheduler.event_running.connect(process_event_running)
	friends_list.add_friend_to_event.connect(add_friend_to_next_event)
	
	trackers[Enums.ActivityType.WALKING] = walking_tracker
	trackers[Enums.ActivityType.CYCLING] = cycling_tracker

func on_event_submitted(hours: int, minutes: int, activity : PhysicalActivity, duration : int, title : String) -> void:
	# Convert to dictionary
	var time : Dictionary = Time.get_datetime_dict_from_system()
	time["hour"] = hours
	time["minute"] = minutes
	
	var success = activity_scheduler.schedule_activity(activity, time, duration, title)
	if success:
		var card : DisplayedActivityNotification = notification_scene.instantiate()
		notification_list.add_child(card)
		card.initialise(success)
		card.activity_value_label.text = "0.0"
		notification_pairs[title] = card

# When a scheduled event starts, start the corresponding tracker
func process_event_started(event: ScheduledActivity) -> void:
	trackers[event.activity.tracker_type].reset()
	trackers[event.activity.tracker_type].start()

# When a scheduled event ends, stop the corresponding tracker
func process_event_ended(event: ScheduledActivity) -> void:
	trackers[event.activity.tracker_type].end()
	print("Activity result : " + event.activity.activity_name + " : " + str(trackers[event.activity.tracker_type].result))
	user_pet.on_event_ended(event)
	notification_pairs[event.title].queue_free()

# When a scheduled event is running, perform its tracker thing
func process_event_running(event: ScheduledActivity) -> void:
	event.result = trackers[event.activity.tracker_type].result
	notification_pairs[event.title].activity_value_label.text = str(event.result)

# Add a friend to the next event to run
func add_friend_to_next_event(friend : String):
	var event = activity_scheduler.get_next_event()
	
	if event:
		notification_pairs[event.title].add_friend(friend)

#region debug

# Debug function to end the event immediately
func force_end_event() -> void:
	if activity_scheduler.current_event:
		activity_scheduler.event_ended.emit(activity_scheduler.current_event)

# For debug
func _on_end_event_button_button_up() -> void:
	force_end_event()

#endregion
