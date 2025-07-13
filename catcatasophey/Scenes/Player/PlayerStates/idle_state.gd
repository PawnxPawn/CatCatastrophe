class_name PlayerIdle
extends State

func enter() -> void:
	parent.velocity.x = 0.0
	parent.animation_component.handle_move_animation(0.0)

func process_input(_event: InputEvent) -> void:
	if parent.input_component.get_direction_input():
		if parent.input_component.get_run_input():
			state_return(&"Run")
		else:
			state_return(&"Walk")
	if parent.input_component.get_jump_input():
		state_return(&"Jump")
	if parent.input_component.get_attack_input():
		return
		#state_return(&"attack")


func process_physics(_delta: float) -> void:
	if !parent.is_on_floor():
		state_return(&"Fall")
