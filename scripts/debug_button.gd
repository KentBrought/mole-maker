extends Button

func _on_pressed_molecule_maker() -> void:
	GameManager.emit_signal("stage_access_enabled", "molecule_maker")


func _on_pressed_synthesis_station() -> void:
	# enable next stage
	GameManager.emit_signal("stage_access_enabled", "synthesis_station")
