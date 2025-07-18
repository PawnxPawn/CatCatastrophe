extends State

func enter() -> void:
	parent.animation_component.animation_player.animation_finished.connect(change_state)

func change_state(_anim_name:StringName) -> void:
	state_return(&"Idle")


func exit() -> void:
	parent.animation_component.animation_player.animation_finished.disconnect(change_state)
