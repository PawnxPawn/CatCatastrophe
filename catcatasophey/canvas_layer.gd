extends CanvasLayer

@onready var page_1: Control = $Page1
@onready var page_2: Control = $Page2
@onready var page_3: Control = $Page3
@onready var page_4: Control = $Page4

var _current_page: int = 1

func _ready() -> void:
	_current_page = 1
	page_1.visible = true
	page_2.visible = false
	page_3.visible = false
	page_4.visible = false
	

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump"):
		_current_page = clampi(_current_page + 1, 1 , 5)
		match _current_page:
			1:
				page_1.visible = true
				page_2.visible = false
				page_3.visible = false
				page_4.visible = false
			2:
				page_1.visible = false
				page_2.visible = true
				page_3.visible = false
				page_4.visible = false
			3:
				page_1.visible = false
				page_2.visible = false
				page_3.visible = true
				page_4.visible = false
			4:
				page_1.visible = false
				page_2.visible = false
				page_3.visible = false
				page_4.visible = true
			5:
				page_1.visible = false
				page_2.visible = false
				page_3.visible = false
				page_4.visible = false
				get_tree().change_scene_to_file("res://Scenes/UI/main_menu_screen.tscn")
