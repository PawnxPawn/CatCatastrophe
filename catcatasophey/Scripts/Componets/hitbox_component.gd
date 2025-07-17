class_name HitboxComponent
extends Area2D

signal hitbox_hit

@export var damage: int = 1
@export var damage_repeat_time: float = 1.0

@onready var timer: Timer = Timer.new()



func _ready():
	area_entered.connect(_on_hurtbox_entered)

func _on_hurtbox_entered(hurtbox: HurtboxComponent):
	if not hurtbox is HurtboxComponent: return
	hurtbox.emit_hurt(self)
	hitbox_hit.emit()
