class_name AnimationComponent
extends Node

@export_group("Nodes")
@export var sprite: AnimatedSprite2D
@export var claw_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer
@export var hitbox_collision: CollisionShape2D
@export var nyon_rainbow: Sprite2D

enum _Direction {
	RIGHT,
	LEFT,
}

var _last_direction: _Direction = _Direction.RIGHT

#TODO: This needs to be updated to handle all characters not just player
func flip_sprite(move_direction:float):
	if move_direction == 0.0:
		return
	
	sprite.flip_h = false if move_direction < 0 else true
	if hitbox_collision != null:
		hitbox_collision.position.x = 22.0 if move_direction > 0 else -22.0
	if claw_sprite != null:
		claw_sprite.flip_h = false if move_direction < 0 else true
	if nyon_rainbow != null:
		nyon_rainbow.position.x = -36.0  if move_direction > 0 else 36.0

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


func handle_glide_animation() -> void:
	animation_player.play(&"glide")


func handle_hurt_animation(last_state:StringName = &"") -> void:
	match last_state:
		&"Jump":
			sprite.modulate = Color(100.0, 100.0, 100.0)
			await get_tree().create_timer(.1).timeout
			sprite.modulate = Color(1.0, 1.0, 1.0)
			animation_player.animation_finished.emit(&"hurt")
		&"Fall":
			sprite.modulate = Color(100.0, 100.0, 100.0)
			await get_tree().create_timer(.1).timeout
			sprite.modulate = Color(1.0, 1.0, 1.0)
			animation_player.animation_finished.emit(&"hurt")
		&"Roll":
			sprite.modulate = Color(100.0, 100.0, 100.0)
			await get_tree().create_timer(.1).timeout
			sprite.modulate = Color(1.0, 1.0, 1.0)
			animation_player.animation_finished.emit(&"hurt")
		&"Glide":
			sprite.modulate = Color(100.0, 100.0, 100.0)
			await get_tree().create_timer(.1).timeout
			sprite.modulate = Color(1.0, 1.0, 1.0)
			animation_player.animation_finished.emit(&"hurt")
		_:
			animation_player.play(&"hurt")


func handle_death_animation() -> void:
	animation_player.play(&"death")
