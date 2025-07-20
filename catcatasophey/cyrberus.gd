extends Character

@export var head_hitbox_component:HitboxComponent
@export var stats: CharacterStats

func _ready() -> void:
	super()
	damage_component.init_damage_component(self, hurtbox_component)
