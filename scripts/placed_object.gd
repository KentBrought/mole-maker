extends Node

@onready var drop_spots = get_parent().get_node("DropSpots").get_children()
var is_dragging = false
var dropped_on_possible_spot = false

# start dragging when the object is clicked
func start_drag():
	is_dragging = true
	# Bring the object to the front visually
	self.z_index = 1000

func _process(_delta):
	# process drag movement
	if is_dragging:
		self.global_position = get_viewport().get_mouse_position()

func _input(event):
	# if the mouse button is released while dragging object
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed and is_dragging:
			is_dragging = false
			#print("Object released, checking drop spots...")
			# reset flag
			dropped_on_possible_spot = false
			# iterate over all nodes in DropSpots
			for drop_spot in drop_spots:
				# check if object is within the drop spot's bounds
				if drop_spot.get_global_rect().has_point(self.global_position):
					#print("Object placed on a valid spot!")
					drop_spot.try_place(self)
					# stop checking where obect was dropped
					dropped_on_possible_spot = true
					break
			# if object not placed on a valid spot -> delete it
			if !dropped_on_possible_spot:
				#print("Object not placed on a valid spot.")
				self.queue_free()
