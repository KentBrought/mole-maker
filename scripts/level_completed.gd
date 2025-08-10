extends Node2D

@onready var star1 = $UILayer/StarDisplay/Star1
@onready var star2 = $UILayer/StarDisplay/Star2
@onready var star3 = $UILayer/StarDisplay/Star3
@onready var star_message = $UILayer/StarDisplay/StarMessage
@onready var heading = $Heading
var star_color = Color("#fed430")
var star_rating = null

func _ready() -> void:
	# instantiate drag and drop
	var drag_and_drop = GameManager.current_level_data.character_sprite.instantiate()
	drag_and_drop.position = Vector2(640, 275)
	add_child(drag_and_drop)
	
	#print("sending star message!")
	star_rating = GameManager.current_level_data.get_star_rating()
	set_star_message()
	animate_star_display()
	
	# set header
	heading.text = GameManager.current_level_data.level_completed_message

func set_star_message():
	#print("star messages: ", star_rating[1])
	# make message
	var message = ""
	for lost_star_message in star_rating[1]:
		message += "Hint: " + lost_star_message + "\n\n"
	if message == "":
		message = "3 stars - great job!"
	# remove 2 trailing newlines
	message = message.substr(0, len(message))
	# set message
	star_message.text = message
	
func animate_star_display():
	#print("num stars: ", star_rating[0])
	if star_rating[0] >= 1:
		star1.get_node("StarMain").color = star_color
	if star_rating[0] >= 2:
		star2.get_node("StarMain").color = star_color
	if star_rating[0] >= 3:
		star3.get_node("StarMain").color = star_color
	for star in [star1, star2, star3]:
		star.scale = Vector2(0.1, 0.1)
		# animate stars using a tween method
		var star_tween = create_tween()
		star_tween.parallel().tween_property(star, "modulate", Color("#ffffff"), 0.75)
		star_tween.parallel().tween_property(star, "scale", Vector2.ONE, 0.75)
		star_tween.parallel().tween_property(star, "rotation", TAU, 0.75)
		AudioManager.star()
		await star_tween.finished
	var message_tween = create_tween()
	message_tween.parallel().tween_property(star_message, "modulate", Color("#ffffff"), 1)
	await message_tween.finished

func _on_back_button_pressed() -> void:
	# back to level select
	get_tree().change_scene_to_file("res://scenes/LevelSelect.tscn")
	GameManager.end_level()
	AudioManager.button_click()

func _on_options_button_pressed() -> void:
	# show options overlay
	$UILayer/OptionsOverlay.visible = true
	AudioManager.button_click()
