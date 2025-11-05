class_name DisplayedActivityNotification extends PanelContainer

@onready
var activity_label : Label = $MarginContainer/HBoxContainer/Details/Activity

@onready
var time_label : Label = $MarginContainer/HBoxContainer/Details/Time

@onready
var title_label : Label = $MarginContainer/HBoxContainer/Tracking/Title

@onready
var ends_label : Label = $MarginContainer/HBoxContainer/Details/EndsAt

@onready
var activity_value_label : Label = $MarginContainer/HBoxContainer/Tracking/ValueDisplay

func initialise(scheduled_activity : ScheduledActivity) -> void:
	var start : Dictionary = scheduled_activity.starts
	var ends : int = Time.get_unix_time_from_datetime_dict(start)
	ends += (scheduled_activity.duration * 60)
	
	activity_label.text = scheduled_activity.activity
	time_label.text = Time.get_datetime_string_from_datetime_dict(start, true)
	ends_label.text = Time.get_datetime_string_from_unix_time(ends, true)
