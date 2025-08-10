class_name AtomAssembler 
extends Node2D

@onready var atom_list = $AtomList/RichTextLabel
@onready var proton_counter = $Protons/Count
@onready var neutron_counter = $Neutrons/Count
@onready var electron_counter = $Electrons/Count
var protons  : int = 0
var neutrons : int = 0
var electrons : int = 0
# structure: <protons>: [<electrons>, <neutrons>, <full name>, <shorthand>]
const possible_atoms = {
	1:  [1, 0, "Hydrogen", "H"],
	2:  [2, 2, "Helium", "He"],
	3:  [3, 4, "Lithium", "Li"],
	4:  [4, 5, "Beryllium", "Be"],
	5:  [5, 6, "Boron", "B"],
	6:  [6, 6, "Carbon", "C"],
	7:  [7, 7, "Nitrogen", "N"],
	8:  [8, 8, "Oxygen", "O"],
	9:  [9, 10, "Fluorine", "F"],
	10: [10, 10, "Neon", "Ne"],
	11: [11, 12, "Sodium", "Na"],
	12: [12, 12, "Magnesium", "Mg"],
	13: [13, 14, "Aluminum", "Al"],
	14: [14, 14, "Silicon", "Si"],
	15: [15, 16, "Phosphorus", "P"],
	16: [16, 16, "Sulfur", "S"],
	17: [17, 18, "Chlorine", "Cl"],
	18: [18, 22, "Argon", "Ar"],
	19: [19, 20, "Potassium", "K"],
	20: [20, 20, "Calcium", "Ca"]
}

func _ready():
	_update_atom_list()
	update_counters()

func create_atom():
	if protons in possible_atoms.keys():
		var element_dict_entry = possible_atoms[protons]
		if electrons == element_dict_entry[0] && neutrons == element_dict_entry[1]:
			#print("made " + element_dict_entry[2] + "!")
			if element_dict_entry[3] not in GameManager.current_level_data.current_atoms:
				GameManager.current_level_data.current_atoms.append(element_dict_entry[3])
				AudioManager.success()
			else:
				AudioManager.button_click()
		else:
			AudioManager.fail()
	else:
		#print("Not a known atom!")
		AudioManager.fail()
	#print("current atoms: ", GameManager.current_level_data.current_atoms)
	_update_atom_list()
	_stage_complete_check()
	protons = 0
	neutrons = 0
	electrons = 0
	update_counters()

func add_atom_components(component_type: String, number: int):
	if component_type == "proton":
		protons = min(1000, protons + number)
	elif component_type == "neutron":
		neutrons = min(1000, neutrons + number)
	elif component_type == "electron":
		electrons = min(1000, electrons + number)
	else:
		push_error("Invalid atom component type!")
	update_counters()

func update_counters():
	proton_counter.text = "Protons:\n"
	neutron_counter.text = "Neutrons:\n"
	electron_counter.text = "Electrons:\n"
	proton_counter.text += str(protons)
	neutron_counter.text += str(neutrons)
	electron_counter.text += str(electrons)

func _update_atom_list():
	atom_list.text = "[b]Your Atoms:[/b]\n\n"
	for atom in GameManager.current_level_data.current_atoms:
		atom_list.text += atom + "\n"

func _stage_complete_check():
	#print("checking if stage is completed...")
	if GameManager.current_level_data:
		GameManager.current_level_data.check_atom_assembler_completed()
		if GameManager.current_level_data.atom_assembler_completed:
			#print("Atom assembler stage completed!")
			# enable next stage
			GameManager.current_level_data.atom_assembler_completed = true
			GameManager.emit_signal("stage_access_enabled", "molecule_maker")
			#print("next stage available!")
		#else:
			#print("Atom assembler stage not completed.")
	else:
		push_error("No current level data!")

func _on_reset_atom_button_pressed() -> void:
	AudioManager.button_click()
	protons = 0
	neutrons = 0
	electrons = 0
	update_counters()
