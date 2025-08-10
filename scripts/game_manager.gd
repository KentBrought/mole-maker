extends Node

var current_level_data = null
var level_records = {}
signal stage_access_enabled(stage_name: String)

func start_level(level_name: String):
	#print("level start: " + level_name)
	if level_name == "level_1":
		var level_data_script = preload("res://Prefabs/level1/level_1_data.gd")
		current_level_data = level_data_script.new()
	elif level_name == "level_2":
		var level_data_script = preload("res://Prefabs/level2/level_2_data.gd")
		current_level_data = level_data_script.new()
	elif level_name == "level_3":
		var level_data_script = preload("res://Prefabs/level3/level_3_data.gd")
		current_level_data = level_data_script.new()
	elif level_name == "level_4":
		var level_data_script = preload("res://Prefabs/level4/level_4_data.gd")
		current_level_data = level_data_script.new()
	elif level_name == "level_5":
		var level_data_script = preload("res://Prefabs/level5/level_5_data.gd")
		current_level_data = level_data_script.new()
	elif level_name == "level_6":
		var level_data_script = preload("res://Prefabs/level6/level_6_data.gd")
		current_level_data = level_data_script.new()
	elif level_name == "level_7":
		var level_data_script = preload("res://Prefabs/level7/level_7_data.gd")
		current_level_data = level_data_script.new()
	elif level_name == "level_8":
		var level_data_script = preload("res://Prefabs/level8/level_8_data.gd")
		current_level_data = level_data_script.new()
	elif level_name == "level_9":
		var level_data_script = preload("res://Prefabs/level9/level_9_data.gd")
		current_level_data = level_data_script.new()
	else:
		push_error("invalid level selected!")

func end_level():
	#print("level over!")
	# record star rating if level is completed
	if current_level_data.star_rating:
		#print("star rating recorded: ", current_level_data.star_rating)
		# if rating already achieved, keep best
		if level_records.has(current_level_data.level_name):
			level_records[current_level_data.level_name] = max(current_level_data.star_rating, level_records[current_level_data.level_name])
		# otherwise record new rating
		else:
			level_records[current_level_data.level_name] = current_level_data.star_rating
	#else:
		#print("no star rating found")
	current_level_data = null
	#print("level records: ", level_records)
