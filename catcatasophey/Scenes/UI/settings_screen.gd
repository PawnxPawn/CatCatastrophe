extends CanvasLayer

@onready var music_slider: HSlider = $MusicSlider
@onready var sfx_slider: HSlider = $SFXSlider

var _inital: bool = true

signal close_settings


func _on_return_button_pressed() -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(music_slider.value))
	AudioServer.set_bus_volume_db(2, linear_to_db(sfx_slider.value))
	GlobalAudio.music_db = music_slider
	GlobalAudio.sfx_db = sfx_slider
	close_settings.emit()


func _on_visibility_changed() -> void:
	if !_inital:
		music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
		sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	_inital = false
