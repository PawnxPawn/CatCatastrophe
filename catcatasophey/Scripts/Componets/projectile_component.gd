class_name ProjectileComponent
extends Node

@export var projectile_scene: PackedScene
@export var fire_location: Marker2D
@export var sprite: AnimatedSprite2D

func fire_projectile() -> void:
	var projectile_instantiated = projectile_scene.instantiate()
	projectile_instantiated.position = fire_location.position
	projectile_instantiated.flip_h = sprite.flip_h
	get_parent().add_child(projectile_instantiated)
