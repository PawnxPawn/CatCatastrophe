extends Node

enum SignalTypes {
	TEST
}

signal test

func emit_signal_bus(signal_type:SignalTypes) -> void:
	match signal_type:
		SignalTypes.TEST:
			test.emit()
