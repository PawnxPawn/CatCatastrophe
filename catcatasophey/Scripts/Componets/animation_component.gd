class_name AnimationComponent
extends Node

@export_group("Nodes")
@export var sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer

enum _Direction {
	DOWN,
	UP,
	LEFT,
	RIGHT,
}

var _last_direction: _Direction = _Direction.DOWN

func handle_move_animation(move_direction: Vector2) -> void:
	
	if move_direction == Vector2.ZERO:
		_run_idle_animation()
		return
	
	
	
	if move_direction.x < 0.0:
		animation_player.play(&"walk_left")
		_last_direction = _Direction.LEFT
	elif move_direction.x > 0.0:
		animation_player.play(&"walk_right")
		_last_direction = _Direction.RIGHT
	elif move_direction.y < 0.0:
		animation_player.play(&"walk_up")
		_last_direction = _Direction.UP
	elif move_direction.y > 0.0:
		animation_player.play(&"walk_down")
		_last_direction = _Direction.DOWN


func _run_idle_animation() -> void:
	match _last_direction:
		_Direction.UP:
			animation_player.play(&"idle_up")
		_Direction.DOWN:
			animation_player.play(&"idle_down")
		_Direction.LEFT:
			animation_player.play(&"idle_left")
		_Direction.RIGHT:
			animation_player.play(&"idle_right")
		_:
			animation_player.play(&"idle_down")


func attack_animation() -> void:
	match _last_direction:
		_Direction.UP:
			animation_player.play(&"attack_up")
		_Direction.DOWN:
			animation_player.play(&"attack_down")
		_Direction.LEFT:
			animation_player.play(&"attack_left")
		_Direction.RIGHT:
			animation_player.play(&"attack_right")
		_:
			animation_player.play(&"attack_down")



func _handle_horizontal_flip(move_direction: float) -> void:
	if move_direction == 0.0:
		return
	
	sprite.flip_h = false if move_direction > 0 else true
