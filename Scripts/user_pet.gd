class_name UserPet extends Node

# The pet acts as a representation of the physical activity performed by the user
# Its stats will change based on the result of an activity

@onready
var debug_stats_label : Label = $DebugContainer/StatsLabel

@onready
var debug_button_list : VBoxContainer = $DebugContainer/ButtonContainer/VBoxContainer

@onready
var debug_button : PackedScene = load("res://Scenes/debug_button.tscn")

@onready
var pet_image : TextureRect = $DebugContainer/PetImage

@export
var _stats : Array[String]

@export
var max_stat_saturate : float = 10

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
	update_pet()

# Process the activity and then run its process
func on_event_ended(event: ScheduledActivity) -> void:
	
	if event.activity == "Walking":
		var stat_boosts : Dictionary = process_walking(event)
		combine_at_intersection(pet_stats, stat_boosts)
	
	update_pet()

# Will return the result of the stat increase for walking
func process_walking(event: ScheduledActivity) -> Dictionary:
	var out : Dictionary = create_pet_dict()
	out["Speed"] = 0.5 * event.result
	out["Health"] = 1
	return out 

# Updates the text which displays the pet stats
func update_display_stats() -> void:
	var label_string : String = ""
	for stat in pet_stats.keys():
		var string : String = stat + " : " + str(pet_stats[stat])
		label_string += string + "\n"
	debug_stats_label.text = label_string

# Instatiate buttons in the pet debug
func load_debug_buttons() -> void:
	for stat in pet_stats.keys():
		var button : Button = debug_button.instantiate()
		debug_button_list.add_child(button)
		button.text = "+1 " + stat
		
		# Add binding
		button.button_up.connect(func(): increment_stat(stat))

# Debug function to manually add stats
func increment_stat(stat : String):
	pet_stats[stat] += 1
	update_pet()

# Handles all functions for updating the pet
func update_pet() -> void:
	update_display_stats()
	reload_pet()

# Updates the pet from its stats
func reload_pet() -> void:
	
	# Different pet stats will correlate to different modulate parameters
	var new_col : Color = Color()
	var i : int = 0
	for stat in pet_stats.keys():
		var val : float = get_rgba_value_from_stat(pet_stats[stat])
		match i:
			0:
				new_col.r = val
			1:
				new_col.g = val
			2:
				new_col.b = val
			3:
				new_col.a = val
		i += 1
	pet_image.modulate = new_col

# Returns a value from 0-1 to use in a rgba
func get_rgba_value_from_stat(value : float) -> float:
	var out : float = value
	
	# Logic for manipulating the stat value into an out value goes here
	out *= 0.1
	
	return clamp(out, 0.0, 1.0)

# Creates an empty dictionary of pet values
func create_pet_dict() -> Dictionary:
	var out_dict : Dictionary
	for stat in _stats:
		out_dict[stat] = 0.0	
	return out_dict

func combine_at_intersection(target : Dictionary, dict : Dictionary) -> Dictionary:
	var out : Dictionary = target
	
	for key in out.keys():
		if dict.has(key):
			out[key] += dict[key]
	
	return out
