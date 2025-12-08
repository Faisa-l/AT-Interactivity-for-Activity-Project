class_name DisplayedActivityNotification extends PanelContainer

@onready
var activity_label : Label = $MarginContainer/VBoxContainer/HBoxContainer/Details/Activity

@onready
var time_label : Label = $MarginContainer/VBoxContainer/HBoxContainer/Details/Time

@onready
var title_label : Label = $MarginContainer/VBoxContainer/HBoxContainer/Tracking/Title

@onready
var ends_label : Label = $MarginContainer/VBoxContainer/HBoxContainer/Details/EndsAt

@onready
var name_label : Label = $MarginContainer/VBoxContainer/EventName

@onready
var activity_value_label : Label = $MarginContainer/VBoxContainer/HBoxContainer/Tracking/ValueDisplay

@onready
var measurement_label : Label = $MarginContainer/VBoxContainer/HBoxContainer/Tracking/Title

@onready
var friends_label : Label = $MarginContainer/VBoxContainer/ParticipatingFriends

var friends : Array[String]

func initialise(scheduled_activity : ScheduledActivity) -> void:
	
	var start : Dictionary = scheduled_activity.starts
	var ends : int = Time.get_unix_time_from_datetime_dict(start)
	ends += (scheduled_activity.duration * 60)
	
	activity_label.text = scheduled_activity.activity.activity_name
	time_label.text = Time.get_datetime_string_from_datetime_dict(start, true)
	ends_label.text = Time.get_datetime_string_from_unix_time(ends, true)
	name_label.text = scheduled_activity.title
	measurement_label.text = scheduled_activity.activity.measurement

func add_friend(friend : String):
	if friends.has(friend): return
	friends.append(friend)
	
	# Make text to display
	var i = friends.size()
	var j = 0
	var new_text : String = ""
	for n in friends:
		j += 1
		new_text = new_text + n
		
		# Add comma if there is another friend
		if (j + 1) <= i: new_text = new_text + ", "
	
	friends_label.text = new_text
