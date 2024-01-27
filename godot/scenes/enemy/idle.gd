extends State

@export
var walk_state: State
@export
var attack_state: State

func enter() -> void:
	parent.animations.play(animation_name)

func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

func process_frame(_delta: float) -> State:
	if parent.player_chase:
		return walk_state
	return null

func _on_detection_area_body_entered(body: Player) -> void:
	parent.player_chase = body
	

