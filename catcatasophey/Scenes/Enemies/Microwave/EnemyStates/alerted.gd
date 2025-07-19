extends State

func enter() -> void:
	parent.velocity.x = 0.0
	parent.animation_component.animation_player.play(&"detected")
	parent.in_alert_mode = true
	parent.animation_component.animation_player.animation_finished.connect(alert_finished)
	parent.stats.damage_taken.connect(enemy_hurt)
	parent.detection_area_component.player_left_dection.connect(alert_mode_deactivated)


func enemy_hurt() -> void:
	state_return(&"Hurt")


func alert_mode_deactivated() -> void:
	state_return(&"Confused")


func alert_finished(anim_name:StringName) -> void:
	if anim_name ==  &"detected":
		state_return(&"Attack" if parent.line_of_sight_component.is_player_in_sight else &"Walk")


func exit() -> void:
	parent.animation_component.animation_player.animation_finished.disconnect(alert_finished)
	parent.stats.damage_taken.disconnect(enemy_hurt)
	parent.detection_area_component.player_left_dection.disconnect(alert_mode_deactivated)
