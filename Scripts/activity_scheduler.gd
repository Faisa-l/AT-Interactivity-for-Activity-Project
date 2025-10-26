# Handles time schedules for things to happen
# Currently looking to just track for the current day - month and years are ignored, as well as seconds

extends Node

var schedule : Array[ScheduledActivity]
var current_event : ScheduledActivity

# Schedules an activity_name to perform at
func schedule_activity(activity_name : String, starts : Dictionary[String, int], duration : int):
	# Make sure activity is not overlapping an existing one
	var bstart : int = Time.get_unix_time_from_datetime_dict(starts)
	var bend : int = bstart + (duration*60)
	for event in schedule:
		var astart : int = Time.get_unix_time_from_datetime_dict(event.starts)
		var aend : int = astart + (event.duration*60)
		if (astart <= bend and bstart <= aend): 
			print("Scheduled activity will overlap another.")
			return
	
	var new_activity : ScheduledActivity = null
	new_activity.activity = activity_name
	new_activity.starts = starts
	new_activity.duration = duration
	schedule.push_back(new_activity)

func _process(delta: float) -> void:
	
	var now : int = Time.get_unix_time_from_system()
	for event in schedule:
		# Should an activity be running now?
		var start : int = Time.get_unix_time_from_datetime_dict(event.starts)
		var end : int = start + (event.duration*60)
		if (start <= now and now <= end):
			if !current_event: 
				current_event = event
			break
		else:
			current_event = null
