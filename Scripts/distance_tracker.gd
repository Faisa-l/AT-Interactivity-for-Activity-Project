class_name DistanceTracker extends Node

# Android specific class which will (attempt to) poll the device for the distance it has travelled

# NOTE: this class will not work unless project is running on a phone
# Will always return null when this is ran on desktop
var AndroidServices = null

@onready
var tex : TextureRect = $"../TextureRect"

func _ready() -> void:
	initalise()

func initalise() -> void:
	
	AndroidServices = Engine.get_singleton("AndroidTelemetryUtils")
	if !AndroidServices:
		print("No android plugin")
		return
	
	AndroidServices.TestSignal.connect(signal_return)
	
	AndroidServices.DisplayToast("Hi")
	AndroidServices.InvokeTestSignal()

func _physics_process(_delta: float) -> void:
	if !AndroidServices: return
	
	#region Indicates whether a phone is connected
	var col : Color = tex.modulate
	col.a8 = clamp(pow(Input.get_accelerometer().length(),2), 0, 255)
	tex.modulate = col
	#endregion

func signal_return(string : String) -> void:
	print(string)
