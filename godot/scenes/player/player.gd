class_name Player
extends CharacterBody2D

@onready
var animations = $AnimatedSprite2D
@onready
var state_machine = $StateMachine
@onready
var attack_range = $AttackRange
@onready
var attack_timer = $AttackTimer

@export
var attack_cooldown: float = 1.0

signal enemy_hit

# Storing direction so that idle can return to the correct direction.
var dir = Constants.Direction.DOWN

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
