class_name AnimationComponent
extends Node

@export_group("Nodes")
@export var sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer

enum _Direction {
	RIGHT,
	LEFT,
}

var _last_direction: _Direction = _Direction.RIGHT

func flip_sprite(move_direction:float):
	if move_direction == 0.0:
		return
	
	sprite.flip_h = false if move_direction < 0 else true

func handle_move_animation(move_direction: float, is_running:bool = false) -> void:
	if move_direction == 0.0:
		_handle_idle_animation()
		return
	
	if move_direction < 0.0:
		_last_direction = _Direction.LEFT
		flip_sprite(move_direction)
		animation_player.play(&"walk" if !is_running else &"run")
	elif move_direction > 0.0:
		_last_direction = _Direction.RIGHT
		flip_sprite(move_direction )
		animation_player.play(&"walk" if !is_running else &"run")

func _handle_idle_animation() -> void:
	match _last_direction:
		_Direction.LEFT:
			sprite.flip_h = false
			animation_player.play(&"idle")
		_Direction.RIGHT:
			sprite.flip_h = true
			animation_player.play(&"idle")
		_:
			sprite.flip_h = false
			animation_player.play(&"idle")


func handle_jump_animation(is_falling:bool = false) -> void:
	if animation_player.current_animation != &"jump_up" && !is_falling:
		animation_player.play(&"jump_up")
	if animation_player.current_animation != &"jump_down" && is_falling:
		animation_player.play(&"jump_down")


func attack_animation() -> void:
	match _last_direction:
		_Direction.LEFT:
			animation_player.play(&"attack_left")
		_Direction.RIGHT:
			animation_player.play(&"attack_right")
