class_name DistanceTracker extends Node

# Android specific class which retrieves step counter sensor data for a pedometer

# NOTE: this class will not work unless project is running on a phone
# Will always return null when this is ran on desktop
var AndroidServices = null

# Foreground service started
var started = false

# Sensor tracking started
var tracking = false

@onready
var tex : TextureRect = $"../TextureRect"

func _ready() -> void:
	initalise()

func initalise() -> void:
	
	AndroidServices = Engine.get_singleton("AndroidTelemetryUtils")
	if !AndroidServices:
		print("No android plugin")
		return
	
	AndroidServices.Initialise()
	AndroidServices.RequestPermissions()


func _on_button_button_up() -> void:
	if !started:
		AndroidServices.InitialiseService()
		started = true
	else:
		if !tracking:
			AndroidServices.StartStepCounterSensor()
			tracking = true
		else:
			AndroidServices.EndStepCounterSensor()

func _on_timer_2_timeout() -> void:
	if AndroidServices.IsStepCounterValid():
		if started:  
			var data = AndroidServices.GetStepData()
			if data:
				print(data)
				$"../Label".text = str(data["rawsteps"])
	else:
		AndroidServices.InitialiseStepCounter()
	
	
