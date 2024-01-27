extends State

@export
var walk_state: State
@export
var attack_state: State


func enter() -> void:
	parent.animations.play(animation_name)
	parent.velocity = Vector2.ZERO

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('attack'):
		return attack_state
	return null

func process_physics(delta: float) -> State:
	return null
