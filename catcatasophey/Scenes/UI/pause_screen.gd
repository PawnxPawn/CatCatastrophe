extends CanvasLayer

@onready var settings_screen: CanvasLayer = $SettingsScreen

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") and !settings_screen.visible:
		get_tree().paused = !get_tree().paused
		visible = true


func _on_resume_button_pressed() -> void:
	visible = false
	get_tree().paused = false


func _on_options_button_pressed() -> void:
	visible = false
	settings_screen.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu_screen.tscn")


func _on_settings_screen_close_settings() -> void:
	visible = true
	settings_screen.visible = false
