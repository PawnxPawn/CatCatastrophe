extends CanvasLayer

func _ready() -> void:
	if GlobalInfo.has_won == true:
		GlobalAudio.set_track(&"credits")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump"):
		get_tree().change_scene_to_file("res://Scenes/UI/main_menu_screen.tscn")
		
