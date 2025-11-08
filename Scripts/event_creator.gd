class_name EventCreator extends PanelContainer

signal event_submitted(hours: int, minutes: int, activity : PhysicalActivity, duration : int, title : String)

@onready
var hours_box : SpinBox = $Container/HBoxContainer/Hours/HourEdit

@onready
var minutes_box : SpinBox = $Container/HBoxContainer/Minutes/MinuteEdit

#@onready
#var activity_box : LineEdit = $Container/HBoxContainer/Activity/ActivityEdit

@onready
var activity_list : PhysicalActivityList = $Container/HBoxContainer/Activity/PhysicalActivityList

@onready
var duration_box : SpinBox = $Container/HBoxContainer/Duration/DurationEdit

@onready
var name_box : LineEdit = $Container/EventName/NameEdit

@onready
var button : Button = $Container/Button

func _ready() -> void:
	hours_box.get_line_edit().context_menu_enabled = false
	minutes_box.get_line_edit().context_menu_enabled = false
	# activity_box.context_menu_enabled = false

# Submit the event
func _on_button_button_up() -> void:
	# Ensure things are valid
	if hours_box.value < 0 or hours_box.value > 24: return
	if minutes_box.value < 0 or minutes_box.value > 60: return
	
	var activity : PhysicalActivity = activity_list.selected
	
	# event_submitted.emit(hours_box.value, minutes_box.value, activity_box.text, duration_box.value, name_box.text)
	event_submitted.emit(hours_box.value, minutes_box.value, activity, duration_box.value, name_box.text)
