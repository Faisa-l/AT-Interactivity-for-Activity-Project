class_name AndriodStepTracker extends Node

# Android specific class which retrieves step counter sensor data for a pedometer

# NOTE: this class will not work unless project is running on a phone
# Will always return null when this is ran on desktop
var AndroidServices = null

# Is this valid
var valid = false

# Foreground service started
var started_service = false

# Sensor tracking started
var tracking = false

# Binding is bound (can access tracker)
var bound = false

# Data retrieved from the step counter
var step_data : Dictionary

func _ready() -> void:
	initialise()

# Initialise this class
func initialise() -> void:
	
	AndroidServices = Engine.get_singleton("AndroidTelemetryUtils")
	if !AndroidServices:
		print("No android plugin")
		return
	
	print("VALID PLUGIN")
	valid = true
	AndroidServices.Initialise()
	AndroidServices.RequestPermissions()

# Initialise (start) the foreground service
func initialise_service():
	print("TRYING TO START")
	if !valid: return
	
	print("STARTING SERVICES")
	if !started_service:
		AndroidServices.InitialiseService()
		started_service = true

# Ends the foreground service this starts
func end_service():
	if !valid: return
	
	if started_service:
		AndroidServices.StopService()
		started_service = false

# Set the service binding for the android plugin
func set_service_binding():
	if !valid || !started_service: return
	
	AndroidServices.SetStepCounterBinding()

# Initialises the step counter
func initialise_step_counter():
	if !valid || !started_service: return
	
	AndroidServices.InitialiseStepCounter()

# Starts the step counter and enables its sensors
func start_step_counter():
	if !valid || !started_service: return
	
	print("STARTING STEP COUNTER")
	AndroidServices.InitialiseStepCounter()
	AndroidServices.StartStepCounterSensor()

# Stops the step counter and disables its sensors 
func end_step_counter():
	if !valid || !started_service: return
	
	AndroidServices.EndStepCounterSensor()

# Resets the step counter's data
func reset_step_counter():
	if !valid || !started_service: return
	
	AndroidServices.ResetStepCounter()

# Retrieve step counter data from the plugin
func get_step_data():
	if !valid || !started_service || !AndroidServices.IsStepCounterValid(): return
	
	var data = AndroidServices.GetStepData()
	if data:
		step_data = data


func _on_check_for_binding_timeout() -> void:
	# Make sure step counter is initialised
	initialise_step_counter()
	
	get_step_data()
