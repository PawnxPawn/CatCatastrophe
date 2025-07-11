class_name MovementComponent
extends Node


@export_group("Setting")
@export var walk_speed: float = 200.0
@export var run_speed: float = 400.0 

var g = Globals
var current_speed: float = walk_speed


func handle_movement(body: CharacterBody2D, direction: Vector2) -> void:
	body.velocity = direction * current_speed


func set_speed(move_type: Globals.MovementType) -> void:
	match move_type:
		g.MovementType.WALK:
			current_speed = walk_speed
		g.MovementType.RUN:
			current_speed = run_speed
