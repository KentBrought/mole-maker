extends Node2D

var ingredients = []
var results = []
var poof
var success_message
var starting_positions = []
var ending_positions = []
var swirl_offsets = []
var swirl_distances = []
var center = Vector2(625, 300)

func _ready() -> void:
	# instantiate synthesis quiz
	var synthesis_quiz = GameManager.current_level_data.synthesis_quiz.instantiate()
	synthesis_quiz.position = Vector2.ZERO
	add_child(synthesis_quiz)
	
	# get references
	poof = synthesis_quiz.get_node("GPUParticles2D")
	success_message = synthesis_quiz.get_node("SuccessMessage")

	# collect ingredient nodes dynamically
	for child in synthesis_quiz.get_children():
		if child.name.begins_with("Ingredient"):
			ingredients.append(child)
			starting_positions.append(child.position)
			var vec = child.position - center
			swirl_distances.append(vec.length())
			swirl_offsets.append(vec.angle())

	# collect result nodes dynamically
	for child in synthesis_quiz.get_children():
		if child.name.begins_with("Result"):
			results.append(child)
			ending_positions.append(child.position)

func _on_mix_button_pressed() -> void:
	mix()
	AudioManager.button_click()
	$MixButton.disabled = true

func mix():
	var swirl_time = 1.75
	AudioManager.mix()

	# animate swirl and fade out
	var ingredient_tween = create_tween()
	ingredient_tween.tween_method(Callable(self, "_update_swirl"), 0.0, 3.0 * TAU, swirl_time)
	for ingredient in ingredients:
		ingredient_tween.parallel().tween_property(ingredient, "modulate", Color(1, 1, 1, 0), swirl_time)
	ingredient_tween.parallel().tween_property($MixButton, "modulate", Color(1, 1, 1, 0), 0.5)
	await ingredient_tween.finished

	# poof
	poof.position = center
	poof.emitting = true
	AudioManager.sparkle()

	# hide ingredients and mix button
	for ingredient in ingredients:
		ingredient.visible = false
	$MixButton.visible = false

	# show results at center, then animate outward
	for result in results:
		result.position = center
		result.visible = true

	success_message.visible = true

	var result_tween = create_tween()
	for i in results.size():
		result_tween.parallel().tween_property(results[i], "modulate", Color(1, 1, 1), swirl_time)
		result_tween.parallel().tween_property(results[i], "position", ending_positions[i], swirl_time)
	result_tween.parallel().tween_property(success_message, "modulate", Color(1, 1, 1), swirl_time)
	await result_tween.finished

func _update_swirl(angle: float):
	var total_angle = 3.0 * TAU
	var progress = clamp(angle / total_angle, 0.0, 1.0)

	var count = ingredients.size()
	for i in count:
		var start_angle = swirl_offsets[i]
		var start_radius = swirl_distances[i]
		var current_angle = start_angle + angle
		var radius = lerp(start_radius, 20.0, progress)
		ingredients[i].position = center + Vector2.RIGHT.rotated(current_angle) * radius
		ingredients[i].scale = Vector2.ONE * lerp(1.0, 0.5, progress)
