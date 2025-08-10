extends LineEdit

func _on_text_changed(new_text: String) -> void:
	const valid_characters = "0123456789"
	var valid_text = ""
	for character in new_text:
		if character in valid_characters:
			valid_text += character
	self.text = valid_text
	self.caret_column = self.text.length()
