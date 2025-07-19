class_name Enemy
extends Character

@export var stats: CharacterStats

@export_category("Microwave Settings")
@export var disable_walk:bool = false

var in_alert_mode = false
var player_position


func _ready() -> void:
	super()
	damage_component.init_damage_component(self, hurtbox_component)
	line_of_sight_component.init_line_of_sight_component(self)
