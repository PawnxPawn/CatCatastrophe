extends State

var is_dead:bool = false

func enter() -> void:
	parent.velocity = Vector2.ZERO
	parent.animation_component.handle_hurt_animation(parent.state_machine.get_last_state.name)
	parent.animation_component.animation_player.animation_finished.connect(hurt_animation_finished)
	parent.stats.dead.connect(check_death)


func hurt_animation_finished(anim_name:StringName) -> void:
	if anim_name == &"hurt":
		state_return(&"Idle")
		return

func check_death() -> void:
		state_return(&"Dead")
		return


func exit() -> void:
	parent.animation_component.animation_player.animation_finished.disconnect(hurt_animation_finished)
	parent.stats.dead.disconnect(check_death)
