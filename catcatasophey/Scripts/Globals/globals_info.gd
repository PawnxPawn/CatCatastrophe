extends Node

var active_checkpoint: Checkpoint:
	set(value):
		active_checkpoint = value
		player_spawn_location = active_checkpoint.global_position

var player_spawn_location: Vector2

var is_in_boss_room = false:
	set(value):
		is_in_boss_room = value
		if is_in_boss_room:
			GlobalAudio.set_track(&"boss")
