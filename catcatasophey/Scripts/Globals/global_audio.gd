extends Node

var music_db = 0.5
var sfx_db = 0.5

@onready var global_music: AudioStreamPlayer = $GlobalMusic

func set_track(track_name: StringName) -> void:
	var playback: AudioStreamPlaybackInteractive = global_music.get_stream_playback()
	playback.switch_to_clip_by_name(track_name)

func get_current_track() -> StringName:
	var playback: AudioStreamPlaybackInteractive = global_music.get_stream_playback()
	return global_music.stream.get_clip_name(playback.get_current_clip_index())
