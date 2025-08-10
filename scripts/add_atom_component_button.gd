extends Button

@onready var root = get_parent().get_parent()

func _on_add_button_pressed() -> void:
	AudioManager.button_click()
	if get_parent().name == "Protons":
		#print("adding protons")
		root.add_atom_components("proton", 1)
	elif get_parent().name == "Neutrons":
		root.add_atom_components("neutron", 1)
		#print("adding neutrons")
	elif get_parent().name == "Electrons":
		root.add_atom_components("electron", 1)
		#print("adding electrons")
	else:
		push_error("Invalid 'add button' parent!")

func _on_subtract_button_pressed() -> void:
	AudioManager.button_click()
	if get_parent().name == "Protons":
		#print("adding protons")
		root.add_atom_components("proton", -1)
	elif get_parent().name == "Neutrons":
		root.add_atom_components("neutron", -1)
		#print("adding neutrons")
	elif get_parent().name == "Electrons":
		root.add_atom_components("electron", -1)
		#print("adding electrons")
	else:
		push_error("Invalid 'add button' parent!")
