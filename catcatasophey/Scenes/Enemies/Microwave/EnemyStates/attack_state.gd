extends State

func enter() -> void:
	parent.animation_component.handle_attack_animation()
	parent.animation_component.animation_player.animation_finished.connect(change_state)
	parent.stats.damage_taken.connect(enemy_damaged)


func change_state(anim_name:StringName) -> void:
	if anim_name == &"attack":
		state_return(&"Idle")


func launch_projectile() -> void:
	parent.projectile_component.fire_projectile()

func enemy_damaged() -> void:
	parent.animation_component.animation_player.stop()
	state_return(&"Hurt")


func exit() -> void:
	parent.animation_component.animation_player.animation_finished.disconnect(change_state)
	parent.stats.damage_taken.disconnect(enemy_damaged)
