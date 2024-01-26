extends State

@export
var walk_state: State
@export
var attack_state: State

# Defined directions (should be refactored in-line with walk.gd)
const move_actions = [
	'move_left',
	'move_right',
	'move_up',
	'move_down',
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
	print("Idle entering :D")
	parent.animations.play(get_direction_as_string(parent.dir) + "_idle")
	#parent.velocity = Vector2.ZERO

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('attack'):
		return attack_state
	
	for action in move_actions:
		if Input.is_action_just_pressed(action):
			return walk_state
	return null

func process_physics(delta: float) -> State:
	return null
