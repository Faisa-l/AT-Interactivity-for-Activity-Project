# Resource asset for each individual physical activity

class_name PhysicalActivity extends Resource

enum ActivityType {WALKING, RUNNING, CYCLING}

# The name of the activity
@export
var activity_name : String

# Type of activity performed
@export
var activity_Type : ActivityType

# How the activity is measured (distance, speed, steps, etc.)
@export
var measurement : String
