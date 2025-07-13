class_name JumpComponent
extends Node

@export var gravity_component:GravityComponent

const MAX_JUMPS: int = 2

var current_jump_limit: int = 2:
	set(value):
		current_jump_limit = clampi(value, 0, MAX_JUMPS)
	get:
		return current_jump_limit
var jump_count: int = 0:
	set(value):
		jump_count = clampi(value, 0, current_jump_limit)

func handle_jump(body: CharacterBody2D, max_jump_height_percentage:float = 1.0) -> void:
	body.velocity.y = gravity_component.apply_launch_velocity(max_jump_height_percentage)
