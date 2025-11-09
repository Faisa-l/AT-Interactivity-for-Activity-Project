class_name DistanceTracker extends Node

# Android specific class which will (attempt to) poll the device for the distance it has travelled

# NOTE: this class will not work unless project is running on a phone
# Will always return null when this is ran on desktop
var AndroidRuntime = Engine.get_singleton("AndroidRuntime")

@onready
var tex : TextureRect = $"../TextureRect"

func _ready() -> void:
	initalise()

func initalise() -> void:
	if !AndroidRuntime:
		print("No android runtime singleton")
		return
	print("hello")

func _physics_process(_delta: float) -> void:
	if !AndroidRuntime: return
	
	var col : Color = tex.modulate
	col.a8 = clamp(pow(Input.get_accelerometer().length(),2), 0, 255)
	tex.modulate = col
