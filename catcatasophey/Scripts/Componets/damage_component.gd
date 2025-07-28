class_name DamageComponent
extends Node
@export var knockback_component: KnockbackComponent
@export var iframe_time:float = 0.5
var knockback_dir: Vector2  = Vector2.ZERO
var _parent: Node = null
var iframe_timer: Timer = Timer.new()
	

func init_damage_component(parent: Node, hurtbox:HurtboxComponent) -> void:
	_parent = parent
	if iframe_time > 0.0:
		iframe_timer.wait_time = iframe_time
		iframe_timer.one_shot = true
	add_child(iframe_timer)
	hurtbox.hurt.connect(_run_hit_detected)


func _run_hit_detected(hitbox:HitboxComponent) -> void:
	if iframe_timer.is_stopped():
		_parent.stats.health -= hitbox.damage
		if knockback_component != null:
			knockback_dir = (hitbox.global_position - _parent.global_position).normalized() * -1
		if iframe_time > 0.0:
			iframe_timer.start()
