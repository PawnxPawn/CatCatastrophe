extends State

func enter() -> void:
	parent.animation_component.animation_player.play(&"Alert")
