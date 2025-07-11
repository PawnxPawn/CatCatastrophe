class_name InputComponent
extends Node

func get_direction_input() -> Vector2:
	return Input.get_vector("move_left","move_right","move_up","move_down")

func get_attack_input() -> bool:
	return Input.is_action_just_pressed("attack")

func get_run_input() -> bool:
	return Input.is_action_pressed("run")
