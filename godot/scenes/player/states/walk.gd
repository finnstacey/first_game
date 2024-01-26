extends State

@export
var idle_state: State
@export
var attack_state: State

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
			
func get_animation_direction(dir: Vector2) -> Constants.Direction:
	if dir.x > 0.0:
		return Constants.Direction.RIGHT
	elif dir.x < 0.0:
		return Constants.Direction.LEFT
	elif is_equal_approx(dir.y, -1.0):
		return Constants.Direction.UP
	else:
		return Constants.Direction.DOWN

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed('attack'):
		return attack_state
	return null

func process_physics(_delta: float) -> State:
	
	#var input_h: float = Input.get_axis('move_left', 'move_right')
	#var input_v: float = Input.get_axis('move_up', 'move_down')
	#var dir: Vector2 = Vector2(input_h, input_v).normalized()
	var input: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input.is_zero_approx():
		return idle_state
	parent.dir = get_animation_direction(input)
	
	# using enum matching but consider using dictionary
	match parent.dir:
		Constants.Direction.UP:
			parent.animations.play("back_" + animation_name)
		Constants.Direction.DOWN:
			parent.animations.play("front_" + animation_name)
		Constants.Direction.RIGHT:
			parent.animations.play("side_" + animation_name)
			parent.animations.flip_h = false
		Constants.Direction.LEFT:
			parent.animations.play("side_" + animation_name)
			parent.animations.flip_h = true
	
	parent.velocity = input.normalized() * move_speed
	parent.move_and_slide()
	
	return null
