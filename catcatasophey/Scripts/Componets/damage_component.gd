class_name DamageComponent
extends Node

@export var iframe_time: float = 0.2
var _iframes_timer: Timer
var _parent: Node = null

func _ready() -> void:
	_iframes_timer = Timer.new()
	add_child(_iframes_timer)
	_iframes_timer.one_shot = true
	_iframes_timer.autostart = false
	_iframes_timer.wait_time = iframe_time
	

func init_damage_component(parent: Node, hurtbox:HurtboxComponent) -> void:
	_parent = parent
	hurtbox.hurt.connect(_run_hit_detected)


func _run_hit_detected(hitbox:HitboxComponent) -> void:
	if _iframes_timer.is_stopped():
			_parent.stats.health -= hitbox.damage
			_iframes_timer.start()
