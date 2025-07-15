class_name CrouchState
extends State

func enter() -> void:
	parent.animation_component.handle_crouch_animation()
	parent.stats.damage_taken.connect(player_damaged)


func process_input(_event: InputEvent) -> void:
	if parent.input_component.get_direction_input():
		state_return(&"Roll")
		return
	
	if parent.input_component.get_jump_input():
		state_return(&"Jump")
		return
	
	if !parent.input_component.get_crouch_held_input():
		state_return(&"Idle")
		return
	
	if parent.input_component.get_attack_input():
		state_return(&"Attack")
		return


func player_damaged() -> void:
	state_return(&"Hurt")


func exit() -> void:
	parent.stats.damage_taken.disconnect(player_damaged)
