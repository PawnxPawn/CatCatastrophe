extends Node

var inital_set: bool = true
var default_checkpoint: Vector2 = Vector2.ZERO
var active_checkpoint_node: Checkpoint


var run_active:bool = false
var jump_active:bool = false
var double_jump_active:bool = false
var roll_active:bool = false
var glide_active:bool = false
var attack_active:bool = false

var active_checkpoint: Vector2:
	set(value):
		print(active_checkpoint)
		if inital_set:
			inital_set = false
			default_checkpoint = active_checkpoint
		active_checkpoint = value
		player_spawn_location = active_checkpoint

var player_spawn_location: Vector2

var is_in_boss_room = false:
	set(value):
		is_in_boss_room = value
		if is_in_boss_room:
			GlobalAudio.set_track(&"boss")
		elif is_in_boss_room:
			GlobalAudio.set_track(&"game")

var has_won = false
