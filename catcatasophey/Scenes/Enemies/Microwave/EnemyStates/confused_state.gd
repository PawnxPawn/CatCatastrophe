extends State

func enter() -> void:
	parent.velocity.x = 0.0
	parent.animation_component.animation_player.play(&"confusion")
	parent.in_alert_mode = false
	parent.animation_component.animation_player.animation_finished.connect(confusion_finished)
	parent.stats.damage_taken.connect(enemy_hurt)
	parent.line_of_sight_component.player_in_sight.connect(alert_mode_activated)


func enemy_hurt() -> void:
	state_return(&"Hurt")


func alert_mode_activated() -> void:
	state_return(&"Alerted")


func confusion_finished(anim_name:StringName) -> void:
	if anim_name == &"confustion":
		state_return(&"Idle")


func exit() -> void:
	parent.animation_component.animation_player.animation_finished.disconnect(confusion_finished)
	parent.stats.damage_taken.disconnect(enemy_hurt)
	parent.line_of_sight_component.player_in_sight.disconnect(alert_mode_activated)
