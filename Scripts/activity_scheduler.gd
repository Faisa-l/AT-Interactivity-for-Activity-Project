class_name ActivityScheduler extends Node

## Handles the scheduling and running of events and activities to perform.

## Fired when the ScheduledActivity has started to run.
signal event_started(event: ScheduledActivity)

## Fired when the ScheduledActivity has ended.
signal event_ended(event: ScheduledActivity)

## Fired when a ScheduledActivity is running, at intervals based on an internal timer.
signal event_running(event: ScheduledActivity)

var schedule : Array[ScheduledActivity]
var current_event : ScheduledActivity

func _ready() -> void:
	event_ended.connect(clear_current_event)

# Schedules an activity_name to perform at
func schedule_activity(activity : PhysicalActivity, starts : Dictionary, duration : int, title : String = "Event") -> ScheduledActivity:
	# Make sure activity is not overlapping an existing one
	var bstart : int = Time.get_unix_time_from_datetime_dict(starts)
	var bend : int = bstart + (duration*60)
	for event in schedule:
		if title == event.title: return
		var astart : int = Time.get_unix_time_from_datetime_dict(event.starts)
		var aend : int = astart + (event.duration*60)
		if (astart <= bend and bstart <= aend): 
			print("Scheduled activity will overlap another.")
			return null
	
	var new_activity : ScheduledActivity = ScheduledActivity.new()
	new_activity.activity = activity
	new_activity.starts = starts
	new_activity.duration = duration
	new_activity.title = title
	schedule.push_back(new_activity)
	print(new_activity.starts)
	return new_activity

# Timer duration will be when this checks for activities
func _on_timer_timeout() -> void:
	# I can definitely do get_next_event is_event_active and simply this 
	# Yet here I am afraid of that causing a bug... and I don't feel lik fixing that
	
	# If an event is currently running, emit that it has ran
	if current_event: event_running.emit(current_event)
	
	# Loop through all possible events in the schedule
	for event in schedule:
		
		# Check if an event needs to be started or ended
		if is_event_active(event):
			# Check if this event has just started
			# An event would have started if the current event was null
			if !current_event: 
				event_started.emit(event)
				current_event = event
			break
		else:
			# Check if this event has just ended
			# An event would have ended if it were previously assigned
			if event == current_event:
				event_ended.emit(event)
				current_event = null

# Checks if this event should be running
func is_event_active(event : ScheduledActivity) -> bool:
	var now : float = Time.get_unix_time_from_system()
	var start : int = Time.get_unix_time_from_datetime_dict(event.starts)
	var end : int = start + (event.duration*60)
	if (start <= now and now <= end):
		print("event " + event.activity.activity_name + " is active")
		return true
	else:
		print("event " + event.activity.activity_name + " is not active")
		return false

# Ensures an event ending clears the current event
func clear_current_event(_event : ScheduledActivity) -> void:
	for i in range(0, schedule.size()):
		if schedule[i] == current_event:
			schedule.remove_at(i)
			current_event = null
			return

# Get the next event to run
func get_next_event() -> ScheduledActivity:
	if current_event: return current_event
	
	# Set event to the smallest diff (event that's closest to running)
	var event : ScheduledActivity = null
	var diff : float = INF
	var now : float = Time.get_unix_time_from_system()
	for e in schedule:
		var at : float = Time.get_unix_time_from_datetime_dict(e.starts)
		var temp = at - now
		if temp < diff:
			event = e
			diff = temp
	
	return event
