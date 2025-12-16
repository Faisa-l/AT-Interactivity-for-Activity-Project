class_name PhysicalActivity extends Resource
## Resource asset for each individual physical activity

# The name of the activity
@export
var activity_name : String

# Type of activity performed
@export
var activity_Type : Enums.ActivityType

# Type of tracker used
@export
var tracker_type : Enums.ActivityType

# How the activity is measured (distance, speed, steps, etc.)
@export
var measurement : String

# Table refers to how the activity affects stats
# Key is the stat name
# Value is the stat increase per point of activity
@export
var stat_table : Dictionary[String, float]
