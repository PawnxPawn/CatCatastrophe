extends Node2D

func _ready() -> void:
	if !GlobalAudio.get_current_track() == &"game":
		GlobalAudio.set_track(&"game")
