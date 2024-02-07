class_name Enemy
extends CharacterBody2D

@onready
var animations = $AnimatedSprite2D
@onready
var state_machine = $StateMachine
var player_chase: Player

# Storing direction so that idle can return to the correct direction.
var dir = Constants.Direction.LEFT

@export
var health: float = 100.0

signal hit

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _on_hit() -> void:
	health -= 50
	if health <= 0.0:
		queue_free()
