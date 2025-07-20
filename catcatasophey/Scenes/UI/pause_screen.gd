extends CanvasLayer

func _ready() -> void:
	GlobalAudio.set_track(&"credits")

func _input(_event: InputEvent) -> void:
	if Input.is_anything_pressed():
		get_tree().change_scene_to_file("res://Scenes/UI/main_menu_screen.tscn")
