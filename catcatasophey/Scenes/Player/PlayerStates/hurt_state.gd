class_name HurtState
extends State

func enter() -> void:
	parent.velocity = Vector2.ZERO
	parent.animation_component.handle_hurt_animation()
	parent.animation_component.animation_player.animation_finished.connect(hurt_animation_finished)


func hurt_animation_finished(anim_name:StringName) -> void:
	if anim_name == &"hurt":
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
		state_return(&"Idle")
		return
	


func exit() -> void:
	parent.animation_component.animation_player.animation_finished.disconnect(hurt_animation_finished)
