class_name PhysicalActivityList extends ScrollContainer

# List will contain all types of physical activites the user can select

@export
var physical_activities : Dictionary[String, PhysicalActivity]

@onready
var container : VBoxContainer = $VBoxContainer

var selected : PhysicalActivity

func _ready() -> void:
	initalise()

# Loads the list with buttons and bind its events
func initalise() -> void:
	for activity in physical_activities.keys():
		var button : Button = Button.new()
		
		button.text = activity
		button.button_up.connect(func(): set_selected(activity))
		
		container.add_child(button)

# Returns the physical activity when a button is clicked
func set_selected(activity : String) -> void:
	selected = physical_activities[activity]
