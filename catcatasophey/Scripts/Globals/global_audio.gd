extends Node

@onready var global_music: AudioStreamPlayer = $GlobalMusic

func set_track(track_name: StringName) -> void:
	var playback: AudioStreamPlaybackInteractive = global_music.get_stream_playback()
	playback.switch_to_clip_by_name(track_name)
