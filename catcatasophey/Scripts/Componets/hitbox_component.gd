class_name HitboxComponent
extends Area2D

@export var damage: int = 5


func _ready():
	area_entered.connect(_on_hurtbox_entered)

func _on_hurtbox_entered(hurtbox: HurtboxComponent):
	if not hurtbox is HurtboxComponent: return
	hurtbox.emit_hurt(self)
