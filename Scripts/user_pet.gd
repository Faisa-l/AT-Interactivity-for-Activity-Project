class_name UserPet extends Node

# The pet acts as a representation of the physical activity performed by the user
# Its stats will change based on the result of an activity

@onready
var debug_stats_label : Label = $DebugContainer/StatsLabel

@onready
var debug_button_list : VBoxContainer = $DebugContainer/ButtonContainer/VBoxContainer

@onready
var debug_button : PackedScene = load("res://Scenes/debug_button.tscn")

@export
var _stats : Array[String]

var pet_stats : Dictionary

func _ready() -> void:
	initialise()

# Sets the stats of the pet
func initialise() -> void:
	
	if pet_stats.size() >=  0:
		pet_stats.clear()
	
	for stat in _stats:
		pet_stats[stat] = 0.0	
	
	load_debug_buttons()
	update_display_stats()

# Process the activity and then run its process
func on_event_ended(event: ScheduledActivity) -> void:
	
	if event.activity == "Walking":
		pet_stats["Speed"] += process_walking(event)
	
	update_display_stats()

# Will return the result of the stat increase for walking
func process_walking(event: ScheduledActivity) -> float:
	return 0.5 * event.result

# Updates the text which displays the pet stats
func update_display_stats() -> void:
	print("New stats:")
	var label_string : String = ""
	for stat in pet_stats.keys():
		var string : String = stat + " : " + str(pet_stats[stat])
		print(string)
		label_string += string + "\n"
	debug_stats_label.text = label_string

# Instatiate buttons in the pet debug
func load_debug_buttons() -> void:
	for stat in pet_stats.keys():
		var button : Button = debug_button.instantiate()
		debug_button_list.add_child(button)
		button.text = "+1 " + stat
		
		# Add binding
		button.button_up.connect(func(): debug_update_stats(stat))

# Debug function to manually add stats
func debug_update_stats(stat : String):
	pet_stats[stat] += 1
	update_display_stats()
