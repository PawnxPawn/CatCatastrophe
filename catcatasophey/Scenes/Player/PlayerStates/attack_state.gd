class_name AttackState
extends State

func enter() -> void:
	parent.animation_component.animation_player.animation_finished.connect(attack_animation_finished)
	parent.animation_component.handle_attack_animation()
	parent.velocity = Vector2.ZERO


func attack_animation_finished(anim_name: StringName) -> void:
	if anim_name == &"attack":
		if parent.input_component.get_direction_input():
			state_return(&"Walk" if !parent.input_component.get_run_input() else &"Run")
			return
		if parent.input_component.get_crouch_held_input():
			state_return(&"Crouch" if !parent.input_component.get_direction_input() else &"Roll")
			return
		state_return(&"Idle")
		return


func exit() -> void:
	parent.animation_component.animation_player.animation_finished.disconnect(attack_animation_finished)
