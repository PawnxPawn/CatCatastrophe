class_name InputComponent
extends Node

func get_direction_input() -> float:
	return Input.get_axis("move_left","move_right")

func get_attack_input() -> bool:
	return Input.is_action_just_pressed("attack")

func get_run_input() -> bool:
	return Input.is_action_pressed("run")
