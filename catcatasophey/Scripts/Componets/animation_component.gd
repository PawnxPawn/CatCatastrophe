class_name AnimationComponent
extends Node

@export_group("Nodes")
@export var sprite: AnimatedSprite2D
@export var claw_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer
@export var hitbox_collision: CollisionShape2D

enum _Direction {
	RIGHT,
	LEFT,
}

var _last_direction: _Direction = _Direction.RIGHT

func flip_sprite(move_direction:float):
	if move_direction == 0.0:
		return
	
	sprite.flip_h = false if move_direction < 0 else true
	hitbox_collision.position.x = 22.0 if move_direction > 0 else -22.0
	if claw_sprite != null:
		claw_sprite.flip_h = false if move_direction < 0 else true

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


func handle_attack_animation() -> void:
	animation_player.play(&"attack")


func handle_roll_animation() -> void:
	animation_player.play(&"roll")
	animation_player.speed_scale = 1.0


func handle_crouch_animation() -> void:
	animation_player.play(&"crouch")


func handle_hurt_animation() -> void:
	animation_player.play(&"hurt")
