extends CanvasLayer

func _ready() -> void:
	if !GlobalAudio.get_current_track() == &"gameover":
		GlobalAudio.set_track(&"gameover")


func _on_yes_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Maps/level_design.tscn")


func _on_no_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu_screen.tscn")
