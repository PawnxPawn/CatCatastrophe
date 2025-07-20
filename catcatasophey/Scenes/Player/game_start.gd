extends State

func enter() -> void:
	parent.animation_component.animation_player.animation_finished.connect(change_state)
	parent.animation_component.handle_start_animation()

func change_state(_anim_name:StringName) -> void:
	state_return(&"Idle")

func process_physics(delta:float) -> void:
	if !parent.is_on_floor():
		parent.velocity.y += parent.gravity_component.apply_fall_gravity() * delta

func exit() -> void:
	parent.animation_component.animation_player.animation_finished.disconnect(change_state)
