extends State


func enter() -> void:
	parent.velocity = Vector2.ZERO
	parent.animation_component.animation_player.animation_finished.connect(death_animation_finished)


func process_physics(delta:float) -> void:
	parent.velocity.y += parent.gravity_component.apply_fall_gravity() * delta

func death_animation_finished(anim_name:StringName) -> void:
	if anim_name == &"hurt":
		parent.animation_component.handle_death_animation()
	if anim_name == &"death":
		GlobalInfo.is_in_boss_room = false
		get_tree().change_scene_to_file("res://Scenes/UI/game_over_screen.tscn")


func exit() -> void:
	parent.animation_component.animation_player.animation_finished.disconnect(death_animation_finished)
