class_name State
extends Node

@export
var animation_name: String
@export
var move_speed: float = 100

## Hold a reference to the parent so that it can be controlled by the state
var parent: CharacterBody2D

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
