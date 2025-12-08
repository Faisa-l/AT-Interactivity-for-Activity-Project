class_name FriendsList extends VBoxContainer

# Class for a list of friends
# You can add friends to the next activity the user is doing
# (this is figurative since it actually cannot display this information)

@onready
var friend_box : PackedScene = load("res://Scenes/friend_box.tscn")

@onready
var name_input : LineEdit = $Debug/NameInput

@onready
var list_container : VBoxContainer = $List

@export
var max_friends : int = 5

var current_friends : int = 0

func add_friend(friend : String):
	
	var box : FriendBox = friend_box.instantiate()
	list_container.add_child(box)
	box.name_label.text = friend
	current_friends += 1


func _on_button_button_up() -> void:
	if name_input.text.length() == 0: return
	
	if current_friends >= max_friends:
		if Engine.has_singleton("AndroidTelemetryUtils"):
			Engine.get_singleton("AndroidTelemetryUtils").DisplayToast("At max friends")
		return
		
	add_friend(name_input.text)
