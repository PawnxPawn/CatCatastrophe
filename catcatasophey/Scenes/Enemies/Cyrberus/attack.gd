extends State

func enter() -> void:
	parent.animation_component.animation_player.play(&"attack1")
	parent.animation_component.animation_player.animation_finished.connect(attack_finished)
	parent.hurtbox_component.hurt.connect(enemy_hurt)
	parent.stats.dead.connect(defeated)


func defeated() -> void:
	if parent.stats.health <= 0:
		state_return(&"Death")


func attack_finished(anim_name:StringName) -> void:
	if anim_name == &"attack1":
		state_return(&"Attack2")


func enemy_hurt(_hitbox: HitboxComponent) -> void:
	parent.animation_component.handle_damage_flash()
	


func  exit() -> void:
	parent.animation_component.animation_player.animation_finished.disconnect(attack_finished)
	parent.hurtbox_component.hurt.disconnect(enemy_hurt)
	parent.stats.dead.disconnect(defeated)
