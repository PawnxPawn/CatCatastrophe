class_name HitboxComponent
extends Area2D

signal hitbox_hit

@export var damage: int = 1
@export var damage_repeat_time: float = 5.0
@export var is_enviorment_detectable = false
@export var walkable_hazard = false


@onready var timer: Timer = Timer.new()

var current_hurtbox: HurtboxComponent = null


func _ready():
	area_entered.connect(_on_hurtbox_entered)
	area_exited.connect(_on_hurtbox_exited)
	body_entered.connect(_on_enviorment_hit)
	timer.wait_time = damage_repeat_time
	timer.timeout.connect(deal_damage)
	timer.one_shot = false


func deal_damage() -> void:
	current_hurtbox.emit_hurt(self)


func _on_enviorment_hit(_enviorment: Node2D) -> void:
	if is_enviorment_detectable:
		hitbox_hit.emit()


func _on_hurtbox_entered(hurtbox: Node2D):
	if not hurtbox is HurtboxComponent: return
	hurtbox.emit_hurt(self)
	hitbox_hit.emit()
	if walkable_hazard == true:
		current_hurtbox = hurtbox
		add_child(timer)
		timer.start()


func _on_hurtbox_exited(_area:Node2D) -> void:
	current_hurtbox = null
	if walkable_hazard == true:
		timer.stop()
		remove_child(timer)
