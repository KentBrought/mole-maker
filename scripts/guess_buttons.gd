extends HBoxContainer

@onready var question_text = get_node("../QuestionText")
@onready var close_overlay_button = get_node("../CloseOverlayButton")

func _on_incorrect_guess_button_pressed() -> void:
	question_text.text = "\n\n[b]Good guess![/b]\n\nLets put it all together now and see if you were right."
	self.visible = false
	close_overlay_button.visible = true
	AudioManager.button_click()

func _on_correct_guess_button_pressed() -> void:
	question_text.text = "\n\n[b]Good guess![/b]\n\nLets put it all together now and see if you were right."
	self.visible = false
	close_overlay_button.visible = true
	GameManager.current_level_data.guess_answered_correctly = true
	AudioManager.button_click()
