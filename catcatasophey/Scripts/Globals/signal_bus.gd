extends Node

enum SignalTypes {
	LEFT_BOSS_AREA,
	ENTERED_BOSS_AREA,
	SET_PLAYER_SPAWN,
}

signal left_boss_area
signal entered_boss_area
signal spawn_player

func emit_signal_bus(signal_type:SignalTypes) -> void:
	match signal_type:
		SignalTypes.LEFT_BOSS_AREA:
			left_boss_area.emit()
		SignalTypes.LEFT_BOSS_AREA:
			entered_boss_area.emit()
		SignalTypes.SET_PLAYER_SPAWN:
			spawn_player.emit()
