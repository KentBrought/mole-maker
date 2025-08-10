extends Node2D 

var levels = ["level_1", "level_2", "level_3", "level_4", "level_5", "level_6", "level_7", "level_8" , "level_9"]
var star_color = Color("#fed430")

func _ready():
	$UI/ScrollContainer/VBoxContainer/Level1Button.pressed.connect(_on_level_1_button_pressed)
	$UI/ScrollContainer/VBoxContainer/Level2Button.pressed.connect(_on_level_2_button_pressed)
	$UI/ScrollContainer/VBoxContainer/Level3Button.pressed.connect(_on_level_3_button_pressed)
	$UI/ScrollContainer/VBoxContainer/Level4Button.pressed.connect(_on_level_4_button_pressed)
	$UI/ScrollContainer/VBoxContainer/Level5Button.pressed.connect(_on_level_5_button_pressed)
	$UI/ScrollContainer/VBoxContainer/Level6Button.pressed.connect(_on_level_6_button_pressed)
	$UI/ScrollContainer/VBoxContainer/Level7Button.pressed.connect(_on_level_7_button_pressed)
	$UI/ScrollContainer/VBoxContainer/Level8Button.pressed.connect(_on_level_8_button_pressed)
	$UI/ScrollContainer/VBoxContainer/Level9Button.pressed.connect(_on_level_9_button_pressed)
	display_stars_and_unlocks()

func display_stars_and_unlocks():
	# go through all known levels
	for level_name in levels:
		var level_num = level_name.split("_")[1]
		var level_button = get_node("UI/ScrollContainer/VBoxContainer/Level" + level_num + "Button")
		# if the level right before has been unlocked, unlock it
		if level_button.disabled:
			var prev_index = levels.find(level_name) - 1
			level_button.disabled = false
			#if GameManager.level_records.has(levels[prev_index]):
				#level_button.disabled = false
		# if it has a rating recorded, display it
		if GameManager.level_records.has(level_name):
			var star_rating = GameManager.level_records[level_name]
			if star_rating >= 1:
				level_button.get_node("Star1/StarMain").color = star_color
			if star_rating >= 2:
				level_button.get_node("Star2/StarMain").color = star_color
			if star_rating >= 3:
				level_button.get_node("Star3/StarMain").color = star_color

func _on_level_1_button_pressed():
	get_tree().change_scene_to_file("res://scenes/LevelMain.tscn")
	GameManager.start_level("level_1")
	AudioManager.button_click()

func _on_level_2_button_pressed():
	get_tree().change_scene_to_file("res://scenes/LevelMain.tscn")
	GameManager.start_level("level_2")
	AudioManager.button_click()

func _on_level_3_button_pressed():
	get_tree().change_scene_to_file("res://scenes/LevelMain.tscn")
	GameManager.start_level("level_3")
	AudioManager.button_click()
	
func _on_level_4_button_pressed():
	get_tree().change_scene_to_file("res://scenes/LevelMain.tscn")
	GameManager.start_level("level_4")
	AudioManager.button_click()
	
func _on_level_5_button_pressed():
	get_tree().change_scene_to_file("res://scenes/LevelMain.tscn")
	GameManager.start_level("level_5")
	AudioManager.button_click()

func _on_level_6_button_pressed():
	get_tree().change_scene_to_file("res://scenes/LevelMain.tscn")
	GameManager.start_level("level_6")
	AudioManager.button_click()

func _on_level_7_button_pressed():
	get_tree().change_scene_to_file("res://scenes/LevelMain.tscn")
	GameManager.start_level("level_7")
	AudioManager.button_click()
	
func _on_level_8_button_pressed():
	get_tree().change_scene_to_file("res://scenes/LevelMain.tscn")
	GameManager.start_level("level_8")
	AudioManager.button_click()
	
func _on_level_9_button_pressed():
	get_tree().change_scene_to_file("res://scenes/LevelMain.tscn")
	GameManager.start_level("level_9")
	AudioManager.button_click()

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
	AudioManager.button_click()
