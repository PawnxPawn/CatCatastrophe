class_name ProjectileComponent
extends Node

@export var projectile_scene: PackedScene
@export var sprite: AnimatedSprite2D

@export_group("Auto Fire")
@export var auto_fire:bool = false
@export var auto_fire_time:float = 0.5
@export var auto_fire_inital_delay: = 0.0
@export_range(-360.0,360.0) var auto_fire_rotation = 0.0

var fire_location: Marker2D
var fire_timer:Timer = Timer.new()

func _ready() -> void:
	fire_location = get_child(0)
	if auto_fire:
		fire_timer.wait_time = auto_fire_time
		fire_timer.one_shot = false
		add_child(fire_timer)
		fire_timer.timeout.connect(auto_fire_launch)
		if auto_fire_inital_delay != 0.0:
			await get_tree().create_timer(auto_fire_inital_delay).timeout
		auto_fire_launch()


func fire_projectile() -> void:
	var projectile_instantiated = projectile_scene.instantiate()
	projectile_instantiated.position = fire_location.position
	projectile_instantiated.flip_h = true if sprite.scale.x == 1.0 else false
	get_parent().add_child(projectile_instantiated)

func auto_fire_launch() -> void:
	var projectile_instantiated = projectile_scene.instantiate()
	projectile_instantiated.rotation = deg_to_rad(auto_fire_rotation)
	projectile_instantiated.position = fire_location.position
	projectile_instantiated.custom_move = true
	projectile_instantiated.flip_h = true
	get_parent().add_child.call_deferred(projectile_instantiated)
	fire_timer.start()
