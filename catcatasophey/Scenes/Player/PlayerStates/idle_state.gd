class_name PlayerIdle
extends State

func process_input(_event: InputEvent) -> void:
	if parent.input_component.get_direction_input():
		state_return(&"Walk")
	if parent.input_component.get_jump_input():
		state_return(&"Jump")

func process_frame(_delta: float) -> void:
	parent.animation_component.handle_move_animation(0.0)
