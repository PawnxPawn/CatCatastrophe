class_name HitboxComponent
extends Area2D

signal hitbox_hit

@export var damage: int = 1
@export var damage_repeat_time: float = 1.0
@export var is_enviorment_detectable = false

@onready var timer: Timer = Timer.new()



func _ready():
	area_entered.connect(_on_hurtbox_entered)
	body_entered.connect(_on_enviorment_hit)


func _on_enviorment_hit(_enviorment: Node2D) -> void:
	if is_enviorment_detectable:
		hitbox_hit.emit()

func _on_hurtbox_entered(hurtbox: Node2D):
	if not hurtbox is HurtboxComponent: return
	hurtbox.emit_hurt(self)
	hitbox_hit.emit()
