extends Node

# level select record variables
var level_name = "level_3"
var star_rating = null

# stage completed variables
var lab_line_completed = false # set true by dialogue button completion
var atom_assembler_completed = false
var molecule_maker_completed = false # set true by molecule_maker script
var synthesis_station_completed = false # set true by Q/A button success

# star system variables
var guess_answered_correctly = false
var level_start_time = Time.get_ticks_msec()
var timer_limit = 180

# lab line variables
var ticket_text = "[b]Want to make:\nCO2[/b]
-------------------
C + O2\n->\nCO2
-------------------
[b]Make atoms:[/b]\nC, O
[b]Make molecules:[/b]\nO2"
var customer_dialogues = [
		[
			"Hey hey!",
			"I need CO2 for my soda machine.",
			"Let’s get fizzing!",
			"Bubbles, here we come!"
		]
	]
var customer = preload("res://Prefabs/level3/customer.tscn")

# atom assembler variables
const required_atoms = ["C", "O"]
var current_atoms = []

# molecule maker variables
var drag_and_drop = preload("res://Prefabs/level3/drag_and_drop.tscn")

# synthesis station variables
var synthesis_quiz = preload("res://Prefabs/level3/synthesis_quiz.tscn")

# level completed variables
var character_sprite = preload("res://Prefabs/level3/character_sprite.tscn")
var level_completed_message = "[b]Level 3 Completed![/b]"

# run every time an atom is made successfully
func check_atom_assembler_completed():
	for atom in required_atoms:
		if atom not in current_atoms:
			atom_assembler_completed = false
			return
	atom_assembler_completed = true
	return

func get_star_rating() -> Array:
	var num_stars = 1
	var messages = []
	# check timer
	var time_elapsed = (Time.get_ticks_msec() - level_start_time) / 1000.0
	print("time to complete level: ", time_elapsed)
	if time_elapsed  <= timer_limit:
		num_stars += 1
	else:
		messages.append("See if you can go even faster next time!")
	# check if final guess was correct
	if guess_answered_correctly:
		num_stars += 1
	else:
		messages.append("Was the extra product what you expected?")
	star_rating = num_stars
	return [num_stars, messages]
