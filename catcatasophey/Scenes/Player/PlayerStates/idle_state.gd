class_name PlayerIdle
extends State

func enter() -> void:
	parent.velocity.x = 0.0
	parent.animation_component.handle_move_animation(0.0)
	parent.cat_collision.disabled = true
	parent.ball_roll_collision.disabled = false
	parent.hurtbox_cat_collision.disabled = true
	parent.hurtbox_roll_collision.disabled = false

func process_input(_event: InputEvent) -> void:
	if parent.input_component.get_direction_input():
		state_return(&"Walk" if !parent.input_component.get_run_input() else &"Run")
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


func exit() -> void:
	parent.cat_collision.disabled = false
	parent.ball_roll_collision.disabled = true
	parent.hurtbox_cat_collision.disabled = false
	parent.hurtbox_roll_collision.disabled = true
