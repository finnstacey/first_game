extends State

@export
var idle_state: State
@export
var attack_state: State

func get_animation_direction(dir: Vector2) -> Constants.Direction:
	if dir.x > 0.0:
		return Constants.Direction.RIGHT
	else:
		return Constants.Direction.LEFT

func process_physics(_delta: float) -> State:
	if !parent.player_chase:
		return idle_state
	var chase_dir: Vector2 = (parent.player_chase.position - parent.position).normalized()
	var velocity: Vector2 = chase_dir * move_speed
	parent.dir = get_animation_direction(chase_dir)
	
	# only animate walk if attack animation has finished
	if !parent.animations.get("animation").contains("attack"):
		match parent.dir:
			Constants.Direction.RIGHT:
				parent.animations.play(animation_name)
				parent.animations.flip_h = false
			Constants.Direction.LEFT:
				parent.animations.play(animation_name)
				parent.animations.flip_h = true
	
	parent.velocity = velocity
	parent.move_and_slide()
	
	return null


func _on_detection_area_body_exited(body: Player) -> void:
	parent.player_chase = null
