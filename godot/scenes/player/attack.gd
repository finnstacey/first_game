extends State

@export
var walk_state: State
@export
var idle_state: State

var attack_finished: bool = false

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
			
func get_animation_direction(dir: Vector2) -> Constants.Direction:
	if dir.x > 0.0:
		return Constants.Direction.RIGHT
	elif dir.x < 0.0:
		return Constants.Direction.LEFT
	elif is_equal_approx(dir.y, -1.0):
		return Constants.Direction.UP
	else:
		return Constants.Direction.DOWN

func enter() -> void:
	# TODO: here to decide whether we should be in the attack state (are we on cooldown)
	#print(parent.attack_timer.is_stopped())
	#print(parent.attack_timer.get_time_left())
	if parent.attack_timer.is_stopped():
		parent.animations.play(get_direction_as_string(parent.dir) + "_" + animation_name)
		var enemy_hitboxes: Array[Area2D] = parent.attack_range.get_overlapping_areas()
		for body in enemy_hitboxes:
			body.get_parent().emit_signal("hit")
		parent.attack_timer.start(5)
	else:
		attack_finished = true
		

func process_input(event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
	
func process_frame(_delta: float) -> State:
	if attack_finished:
		attack_finished = false
		return walk_state

	#var frame: int = parent.animations.get_frame()
	#var frame_progress: float = parent.animations.get_frame_progress()
	var input: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if not input.is_zero_approx():
		parent.dir = get_animation_direction(input)
	
	parent.velocity = input.normalized() * move_speed
	parent.move_and_slide()
	return null

func _on_animated_sprite_2d_animation_looped() -> void:
	if parent.animations.get_animation().ends_with("attack"):
		parent.animations.set_frame_and_progress(3, 1.0)
		parent.animations.pause() # see walk animation logic
		attack_finished = true
	pass


func _on_attack_range_body_entered(body: Node2D) -> void:
	pass
