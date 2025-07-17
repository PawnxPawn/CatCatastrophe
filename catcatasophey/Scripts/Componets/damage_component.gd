class_name DamageComponent
extends Node
@export var knockback_component: KnockbackComponent
var knockback_dir: Vector2  = Vector2.ZERO
var _parent: Node = null
	

func init_damage_component(parent: Node, hurtbox:HurtboxComponent) -> void:
	_parent = parent
	hurtbox.hurt.connect(_run_hit_detected)


func _run_hit_detected(hitbox:HitboxComponent) -> void:
	_parent.stats.health -= hitbox.damage
	if knockback_component != null:
		knockback_dir = (hitbox.global_position - _parent.global_position).normalized() * -1
