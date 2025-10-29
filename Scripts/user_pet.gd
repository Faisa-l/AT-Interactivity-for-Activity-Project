class_name UserPet extends Node

# The pet acts as a representation of the physical activity performed by the user
# Its stats will change based on the result of an activity

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

# Process the activity and then run its process
func on_event_ended(event: ScheduledActivity) -> void:
	
	if event.activity == "Walking":
		pet_stats["Speed"] += process_walking(event)
	
	print("New stats:")
	for stat in pet_stats.keys():
		print(stat + " : " + str(pet_stats[stat]))

# Will return the result of the stat increase for walking
func process_walking(event: ScheduledActivity) -> float:
	return 0.5 * event.result
