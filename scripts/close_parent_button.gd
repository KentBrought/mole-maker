extends Button

func _on_pressed() -> void:
	get_parent().visible = false
	AudioManager.button_click()
