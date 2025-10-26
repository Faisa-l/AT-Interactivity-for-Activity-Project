# Handles time schedules for things to happen
# Currently looking to just track for the current day

extends Node

var schedule : Array[ScheduledActivity]

# Schedules an activity_name to perform at
func schedule_activity(activity_name : String, starts : Dictionary[String, int], ends : Dictionary[String, int]):
	var new_activity : ScheduledActivity
	new_activity.activity = activity_name
	new_activity.starts = starts
	new_activity.ends = ends
	schedule.push_back(new_activity)
