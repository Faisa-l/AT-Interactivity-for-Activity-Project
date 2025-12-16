@abstract
class_name ActivityTracker extends Node

## Abstract class of the functionality of all tracked physical activities.

# Value returned from activity
var result : float

@abstract
func start()

@abstract
func pause()

@abstract
func reset()

@abstract
func end()
