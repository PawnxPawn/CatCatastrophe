extends Character

@export var head_hitbox_component:HitboxComponent
@export var stats: BossStats

func _ready() -> void:
	super()
	print(stats.health)
	damage_component.init_damage_component(self, hurtbox_component)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	move_and_collide(Vector2.ZERO)
