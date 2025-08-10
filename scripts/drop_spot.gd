extends Control

@export var correct_name: String
var current_object: Control = null
var drop_rect: Rect2

func try_place(obj: Control):
	drop_rect = Rect2(global_position, size)
	# object already in this spot
	if current_object != null:
		obj.queue_free() # delete object
		return
	# object is placed correctly
	elif (obj.name.split("_")[0] == correct_name) and (drop_rect.has_point(obj.global_position)):
		current_object = obj
		obj.global_position = global_position # snap object into position
		obj.set_process(false) # stop dragging
		get_parent().get_parent().get_parent().check_solution() # check if all spots matched
		AudioManager.success()
	# object placed incorrectly
	else:
		obj.queue_free() # delete object
		AudioManager.fail()
