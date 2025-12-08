class_name FriendBox extends VBoxContainer

# Box to display information about a friend
# Also has a button to add them to the next activity

# Specifically the button label is supposed to be connected to a function which will add them to a 
# 'friends' list in the ScheduledActivity but this information is not displayed

@onready
var name_label : Label = $Name

@onready
var button : Button = $Button

signal receive_friend_addition(friend : String)

# When button is pressed, emit a signal to add a friend
func _on_button_button_up() -> void:
	receive_friend_addition.emit(name_label.text)
