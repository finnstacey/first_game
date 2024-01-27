extends State

@export
var walk_state: State
@export
var attack_state: State


func enter() -> void:
	parent.animations.play(animation_name)
	parent.velocity = Vector2.ZERO

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("attack"):
		return attack_state
	return null

func process_physics(_delta: float) -> State:
	return null
