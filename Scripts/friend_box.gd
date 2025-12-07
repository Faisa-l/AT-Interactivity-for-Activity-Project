class_name FriendBox extends VBoxContainer

# Box to display information about a friend
# Also has a button to add them to the next activity

# Specifically the button label is supposed to be connected to a function which will add them to a 
# 'friends' list in the ScheduledActivity but this information is not displayed

@onready
var name_label : Label = $Name

@onready
var button : Button = $Button
