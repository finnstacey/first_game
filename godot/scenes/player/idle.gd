extends State

@export
var walk_state: State
@export
var attack_state: State

# Defined directions (should be refactored in-line with walk.gd)
const move_actions: PackedStringArray = [
	StringName('move_left'),
	StringName('move_right'),
	StringName('move_up'),
	StringName('move_down'),
]

func get_direction_as_string(dir: Constants.Direction) -> String:
	match dir:
		Constants.Direction.UP:
			return "back"
		Constants.Direction.DOWN:
			return "front"
		Constants.Direction.LEFT:
			return "side"
		Constants.Direction.RIGHT:
			return "side"
		_:
			return "side"

func enter() -> void:
	parent.animations.play(get_direction_as_string(parent.dir) + "_idle")

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("attack"):
		return attack_state
	return null

func process_frame(_delta: float) -> State:
	for action in move_actions:
		if Input.is_action_pressed(action):
			return walk_state
	return null
	
func process_physics(_delta: float) -> State:
	return null
