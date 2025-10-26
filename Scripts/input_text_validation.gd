# I found this code from Reddit. Forgive me.

extends LineEdit

@export
var allowed_characters : String = "[A-Za-z]"	# do ^[0-9]*$ for numbers only [A-Za-z] for words only

func _on_text_changed(new_text: String) -> void:
	var old_caret_position = caret_column
	
	var word = ''
	var regex = RegEx.new()
	regex.compile(allowed_characters)
	for valid_character in regex.search_all(new_text):
		word += valid_character.get_string()
	self.set_text(word)
	
	caret_column = old_caret_position
