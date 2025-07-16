class_name CollectableComponent
extends Area2D

@export var collectable_type: Globals.CollectableTypes

func _ready() -> void:
	body_entered.connect(_item_pickup)

func _item_pickup(body: Node2D) -> void:
	if body is Player:
		body.activate_ability(collectable_type)
		get_parent().queue_free()
