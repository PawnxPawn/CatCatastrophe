class_name HurtboxComponent
extends Area2D

signal hurt(hitbox)

func emit_hurt(hitbox:HitboxComponent) -> void:
	hurt.emit(hitbox)
