extends VBoxContainer

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
