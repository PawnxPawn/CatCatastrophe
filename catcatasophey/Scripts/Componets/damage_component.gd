class_name DamageComponent
extends Node

func init_damage_component(parent: Node, hurtbox:HurtboxComponent) -> void:
	hurtbox.hurt.connect(func(hitbox: HitboxComponent):
		parent.stats.health -= hitbox.damage)
