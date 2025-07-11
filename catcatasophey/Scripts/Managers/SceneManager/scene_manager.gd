extends Node

var current_scene: Node
var current_level: Dictionary

const level_details: Dictionary = {
	&"main_menu" : {
		&"scene" : &"",
		},
	&"your_farm" : {
		&"scene" : &"", 
	},
}

func goto_scene(_level_name: StringName) -> void:
	current_level = level_details[current_level]
	var path = current_level[&"scene"]
	
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path: StringName) -> void:
	var new_scene = load(path)
	
	current_scene.free()
	current_scene = new_scene.instantiate()
	add_child(current_scene)
