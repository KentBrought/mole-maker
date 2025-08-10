extends Node2D

# preload your stage scenes
var LabLineScene = preload("res://scenes/LabLine.tscn")
var AtomAssemblerScene = preload("res://scenes/AtomAssembler.tscn")
var MoleculeMakerScene = preload("res://scenes/MoleculeMaker.tscn")
var SynthesisStationScene = preload("res://scenes/SynthesisStation.tscn")

# hold references to the instances
var lab_line: Node2D
var atom_assembler: Node2D
var molecule_maker: Node2D
var synthesis_station: Node2D

func _ready():
	# instance them, add under StageContainer
	lab_line = LabLineScene.instantiate()
	atom_assembler = AtomAssemblerScene.instantiate()
	molecule_maker = MoleculeMakerScene.instantiate()
	synthesis_station = SynthesisStationScene.instantiate()
	$StageContainer.add_child(lab_line)
	$StageContainer.add_child(atom_assembler)
	$StageContainer.add_child(molecule_maker)
	$StageContainer.add_child(synthesis_station)

	# show only Lab Line
	lab_line.visible = true
	atom_assembler.visible = false
	molecule_maker.visible = false
	synthesis_station.visible = false

	# hook up nav‐bar buttons correctly using get_node() or $path
	var nav = $UILayer/StageNavBar
	nav.get_node("LabLineButton").connect("pressed", Callable(self, "_on_LabLineButton_pressed"))
	nav.get_node("AtomAssemblerButton").connect("pressed", Callable(self, "_on_AtomAssemblerButton_pressed"))
	nav.get_node("MoleculeMakerButton").connect("pressed", Callable(self, "_on_MoleculeMakerButton_pressed"))
	nav.get_node("SynthesisStationButton").connect("pressed", Callable(self, "_on_SynthesisStationButton_pressed"))

	GameManager.stage_access_enabled.connect(self._on_stage_access_enabled)

func _on_stage_access_enabled(flag_name: String):
	if flag_name == "atom_assembler" and $UILayer/StageNavBar/AtomAssemblerButton.disabled:
		$UILayer/StageNavBar/AtomAssemblerButton.disabled = false
		get_node("UILayer/StageNavBar/AtomAssemblerButton/Lock").visible = false
		AudioManager.unlock()
		#print("button enabled!")
	elif flag_name == "molecule_maker" and $UILayer/StageNavBar/MoleculeMakerButton.disabled:
		$UILayer/StageNavBar/MoleculeMakerButton.disabled = false
		get_node("UILayer/StageNavBar/MoleculeMakerButton/Lock").visible = false
		AudioManager.unlock()
		#print("button enabled!")
	elif flag_name == "synthesis_station" and $UILayer/StageNavBar/SynthesisStationButton.disabled:
		$UILayer/StageNavBar/SynthesisStationButton.disabled = false
		get_node("UILayer/StageNavBar/SynthesisStationButton/Lock").visible = false
		AudioManager.unlock()
		#print("button enabled!")

func _on_LabLineButton_pressed():
	lab_line.visible = true
	atom_assembler.visible = false
	molecule_maker.visible = false
	synthesis_station.visible = false
	AudioManager.button_click()

func _on_AtomAssemblerButton_pressed():
	lab_line.visible = false
	atom_assembler.visible = true
	molecule_maker.visible = false
	synthesis_station.visible = false
	AudioManager.button_click()

func _on_MoleculeMakerButton_pressed():
	lab_line.visible = false
	atom_assembler.visible = false
	molecule_maker.visible = true
	synthesis_station.visible = false
	AudioManager.button_click()

func _on_SynthesisStationButton_pressed():
	lab_line.visible = false
	atom_assembler.visible = false
	molecule_maker.visible = false
	synthesis_station.visible = true
	AudioManager.button_click()

func _on_hint_button_pressed():
	# get hint overlay for that scene
	# show hint overlay
	$UILayer/HintOverlay.visible = true
	AudioManager.button_click()

func _on_periodic_table_button_pressed():
	# show periodic table overlay
	$UILayer/PeriodicTableOverlay.visible = true
	AudioManager.button_click()

func _on_options_button_pressed():
	# show options overlay
	$UILayer/OptionsOverlay.visible = true
	AudioManager.button_click()

func _on_back_button_pressed() -> void:
	# back to level select
	get_tree().change_scene_to_file("res://scenes/LevelSelect.tscn")
	GameManager.end_level()
	AudioManager.button_click()

func _switch_to_atom_assembler() -> void:
	lab_line.visible       = false
	atom_assembler.visible = true
	molecule_maker.visible = false
	synthesis_station.visible = false
