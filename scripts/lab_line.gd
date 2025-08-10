extends Node2D

@onready var customer_dialogues: Array = GameManager.current_level_data.customer_dialogues
@onready var ticket = get_parent().get_parent().get_node("UILayer/TicketSpawn/TicketText")
var current_customer: int = 0
var current_line: int = 0
var dialogue_finished: bool = false
var dialogue_button
var dialogue_label

func _ready() -> void:
	# instantiate character
	var customer = GameManager.current_level_data.customer.instantiate()
	customer.position = Vector2(0, 0)
	add_child(customer)
	
	# get child node referernces
	dialogue_button = $Customer/DialogueUI/DialogueButton
	dialogue_label = $Customer/DialogueUI/DialogueLabel
	
	# setup initial dialogue
	dialogue_label.text = customer_dialogues[current_customer][current_line]
	dialogue_button.text = "Take Order"
	dialogue_button.pressed.connect(_on_dialogue_button_pressed)

# dialogue manager
func _on_dialogue_button_pressed() -> void:
	# if dialogue is finished, switch to atom assembler
	if dialogue_finished:
		get_parent().get_parent()._switch_to_atom_assembler()
		AudioManager.button_click()
		return
	
	# otherwise update current text line
	current_line += 1
	var lines = customer_dialogues[current_customer]
	# if not at the final line
	if current_line < lines.size():
		dialogue_label.text = lines[current_line]
		# first line case
		if current_line == 1:
			dialogue_button.text = "Continue"
	# final line case
	elif current_line == lines.size():
		# reveal ticket text
		if ticket:
			ticket.text = GameManager.current_level_data.ticket_text
			ticket.visible = true
		else:
			push_error("Cannot find TicketText node!")
			
		# stage completed
		dialogue_finished = true
		# enable next stage
		if GameManager.current_level_data:
			GameManager.current_level_data.lab_line_completed = true
			GameManager.emit_signal("stage_access_enabled", "atom_assembler")
			#print("next stage available!")
		dialogue_button.text = "Next Stage"
	AudioManager.button_click()
