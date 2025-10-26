class_name EventCreator extends VBoxContainer

signal event_submitted(hours: int, minutes: int, activity : String)

@onready
var hours_box : SpinBox = $HBoxContainer/Hours/HourEdit

@onready
var minutes_box : SpinBox= $HBoxContainer/Minutes/MinuteEdit

@onready
var activity_box : LineEdit = $HBoxContainer/Activity/ActivityEdit

@onready
var button : Button = $Button

func _ready() -> void:
	hours_box.get_line_edit().context_menu_enabled = false
	minutes_box.get_line_edit().context_menu_enabled = false
	activity_box.context_menu_enabled = false

# Submit the event
func _on_button_button_up() -> void:
	# Ensure things are valid
	if hours_box.value <= 0 or hours_box.value > 24: return
	if minutes_box.value <= 0 or minutes_box.value > 60: return
	
	event_submitted.emit(hours_box.value, minutes_box.value, activity_box.text)
