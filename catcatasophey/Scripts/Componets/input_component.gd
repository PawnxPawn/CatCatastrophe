class_name InputComponent
extends Node

@export var abilities: Abilities

func get_direction_input() -> float:
	return Input.get_axis(&"move_left",&"move_right")


func get_attack_input() -> bool:
	return (Input.is_action_pressed(&"attack") || Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) && abilities.attack_activated


func get_run_input() -> bool:
	return Input.is_action_pressed(&"run") && abilities.run_activated


func get_jump_input() -> bool:
	return Input.is_action_just_pressed(&"jump") && abilities.jump_activated

func get_jump_held_input() -> bool:
	return Input.is_action_pressed(&"jump") && abilities.jump_activated

func  get_crouch_held_input() -> bool:
	return Input.is_action_pressed(&"crouch") && abilities.roll_activated
