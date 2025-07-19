class_name LineOfSightComponent
extends Node2D

signal player_in_sight
signal player_not_in_sight

@export var detection_area_component: DetectionAreaComponent

@export var detection_range: float = 200.0
@export var ray_cast_spacer: float = 5.0
var player_node: Player
var parent: Enemy


func init_line_of_sight_component(owner:Enemy) -> void:
	parent = owner


func _ready() -> void:
	enable_disable_raycast(false)
	
	detection_area_component.player_detected.connect(func(player:Player): 
		player_node = player
		enable_disable_raycast(true))
	detection_area_component.player_detected.connect(func(): 
		player_node = null
		enable_disable_raycast(false))


func enable_disable_raycast(is_enabled:bool):
	for child in get_children():
		child.enabled = is_enabled


func _physics_process(_delta: float) -> void:
	parent.player_position = _get_player_position()
	
	if parent.player_position == Vector2.INF: player_not_in_sight.emit()


func _get_player_position() -> Vector2:
	var ray_cast_height_position:int = 0
	var counter:int = 0
	var position_of_player: Vector2 = Vector2.INF
	
	for child in get_children():
		var player_position = player_node.global_position
		counter += 1
		if player_position.distance_to(global_position) > detection_range:
			position_of_player = Vector2.INF
		
		var ray_cast = child as RayCast2D
		
		ray_cast.target_position = player_position - global_position
		ray_cast.target_position.y += ray_cast_height_position * -1
		ray_cast_height_position *= -1
		
		if counter % 2 == 0: ray_cast_height_position += ray_cast_spacer
		
		if ray_cast.is_colliding() && "Player" in ray_cast.get_collider().name:
			player_in_sight.emit()
			position_of_player = ray_cast.get_collision_point()
	
	return position_of_player
