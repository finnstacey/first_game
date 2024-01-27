extends Node

@export
var starting_state: State
var current_state: State

# Initialize the state machine by giving each child state a reference to the
# parent object it belongs to and enter the default starting_state.
func init(parent: Enemy) -> void:
	print(parent)
	for child in get_children():
		print(child)
		child.parent = parent

	# Initialize to the default state
	change_state(starting_state)

# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()
	
# Pass through functions for the Player to call,
# handling state changes as needed.
func process_physics(delta: float) -> void:
	var new_state: State = current_state.process_physics(delta)
	if new_state: 
		change_state(new_state)
		
	# As a one-off comment: the above statement is equivalent to the verbose:
	# if new_state != null:
	#	change_state(new_state)
	# i.e. we only change state if the new_state isn't a null.

func process_input(event: InputEvent) -> void:
	var new_state: State = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state: State = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)