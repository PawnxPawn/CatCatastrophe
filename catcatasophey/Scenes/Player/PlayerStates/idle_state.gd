class_name PlayerIdle
extends State

func enter() -> void:
	parent.velocity.x = 0.0
	parent.animation_component.handle_move_animation(0.0)
	parent.stats.damage_taken.connect(player_damaged)

func process_input(_event: InputEvent) -> void:
	if parent.input_component.get_direction_input():
		state_return(&"Walk" if !parent.input_component.get_run_input() else &"Run")
		return
	if parent.input_component.get_jump_input():
		state_return(&"Jump")
		return
	if parent.input_component.get_attack_input():
		state_return(&"Attack")
		return
	if parent.input_component.get_crouch_held_input():
		state_return(&"Crouch")
		return
		


func process_physics(_delta: float) -> void:
	if !parent.is_on_floor():
		state_return(&"Fall")


func player_damaged() -> void:
	state_return(&"Hurt")


func exit() -> void:
	parent.stats.damage_taken.disconnect(player_damaged)
