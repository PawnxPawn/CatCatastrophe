class_name KnockbackComponent
extends Node

@export var knockback_strength = 150.0

func apply_knockback(direction: Vector2) -> Vector2:
	return direction * knockback_strength
