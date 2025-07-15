extends State


func enter() -> void:
	parent.velocity = Vector2.ZERO
	parent.animation_component.handle_hurt_animation()
	parent.animation_component.animation_player.animation_finished.connect(death_animation_finished)


func death_animation_finished(anim_name:StringName) -> void:
	if anim_name == &"death":
		return
	pass


func exit() -> void:
	parent.animation_component.animation_player.animation_finished.disconnect(death_animation_finished)
