extends CanvasLayer

@onready var quit_button: TextureButton = $QuitButton
@onready var credits_button: TextureButton = $CreditsButton
@onready var options_button: TextureButton = $OptionsButton
@onready var new_game_button: TextureButton = $NewGameButton
@onready var settings_screen: CanvasLayer = $SettingsScreen

func _ready() -> void:
	GlobalInfo.active_checkpoint = Vector2.ZERO
	GlobalInfo.run_active = false
	GlobalInfo.jump_active = false
	GlobalInfo.double_jump_active = false
	GlobalInfo.roll_active = false
	GlobalInfo.glide_active = false
	GlobalInfo.attack_active = false
	if !GlobalAudio.get_current_track() == &"mainmenu":
		GlobalAudio.set_track(&"mainmenu")


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/credits.tscn")

func _on_options_button_pressed() -> void:
	visible = false
	settings_screen.visible = true


func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Maps/level_design.tscn")


func _on_settings_screen_close_settings() -> void:
	visible = true
	settings_screen.visible = false
