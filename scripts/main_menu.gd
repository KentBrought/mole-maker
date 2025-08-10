extends Node2D

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/LevelSelect.tscn")
	AudioManager.button_click()

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Credits.tscn")
	AudioManager.button_click()

func _on_how_to_play_button_pressed() -> void:
	$CanvasLayer/HowToPlayOverlay.visible = true
	AudioManager.button_click()

func _on_options_button_pressed() -> void:
	$CanvasLayer/OptionsOverlay.visible = true
	AudioManager.button_click()

func _on_close_overlay_button_pressed() -> void:
	$CanvasLayer/HowToPlayOverlay.visible = false
	AudioManager.button_click()
