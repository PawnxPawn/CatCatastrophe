extends CanvasLayer

@onready var quit_button: TextureButton = $QuitButton
@onready var credits_button: TextureButton = $CreditsButton
@onready var options_button: TextureButton = $OptionsButton
@onready var new_game_button: TextureButton = $NewGameButton

func _ready() -> void:
	GlobalAudio.set_track(&"mainmenu")


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/credits.tscn")

func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Maps/level design.tscn")
