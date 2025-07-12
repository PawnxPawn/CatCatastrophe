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

func handle_move_animation(move_direction: float) -> void:
	return
	if !move_direction:
		_run_idle_animation()
		return
	
	
	
	if move_direction < 0.0:
		animation_player.play(&"walk_left")
		_last_direction = _Direction.LEFT
	elif move_direction > 0.0:
		animation_player.play(&"walk_right")
		_last_direction = _Direction.RIGHT


func _run_idle_animation() -> void:
	match _last_direction:
		_Direction.LEFT:
			animation_player.play(&"idle_left")
		_Direction.RIGHT:
			animation_player.play(&"idle_right")
		_:
			animation_player.play(&"idle_left")


func attack_animation() -> void:
	match _last_direction:
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
