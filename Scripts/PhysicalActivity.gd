# Resource asset for each individual physical activity
class_name PhysicalActivity extends Resource

# The name of the activity
@export
var activity_name : String

# Type of activity performed
@export
var activity_Type : Enums.ActivityType

# How the activity is measured (distance, speed, steps, etc.)
@export
var measurement : String
