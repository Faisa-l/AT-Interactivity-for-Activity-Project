class_name DisplayedActivityNotification extends PanelContainer

@onready
var activity_label : Label = $MarginContainer/HBoxContainer/Details/Activity

@onready
var time_label : Label = $MarginContainer/HBoxContainer/Details/Time

@onready
var title_label : Label = $MarginContainer/HBoxContainer/Tracking/Title

@onready
var activity_value_label : Label = $MarginContainer/HBoxContainer/Tracking/ValueDisplay

func initialise(scheduled_activity : ScheduledActivity) -> void:
	activity_label.text = scheduled_activity.activity
	time_label.text = Time.get_datetime_string_from_datetime_dict(scheduled_activity.starts, false)
