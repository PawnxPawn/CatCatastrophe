class_name Enemy
extends Character

@export var stats: CharacterStats

@export_category("Microwave Settings")
@export var disable_walk:bool = false


func _ready() -> void:
	super()
	damage_component.init_damage_component(self, hurtbox_component)
