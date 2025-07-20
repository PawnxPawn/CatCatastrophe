class_name CollectableComponent
extends Area2D

@export var collectable_type: Globals.CollectableTypes

func _ready() -> void:
	match collectable_type:
		Globals.CollectableTypes.JUMP:
			if GlobalInfo.jump_active == true and get_parent().name == &"JumpAbility":
				get_parent().queue_free()
			if GlobalInfo.double_jump_active == true and get_parent().name == &"DoubleJump":
				get_parent().queue_free()
		Globals.CollectableTypes.ROLL:
			if GlobalInfo.roll_active == true:
				get_parent().queue_free()
		Globals.CollectableTypes.RUN:
			if GlobalInfo.run_active == true:
				get_parent().queue_free()
		Globals.CollectableTypes.ATTACK:
			if GlobalInfo.attack_active == true:
				get_parent().queue_free()
		Globals.CollectableTypes.GLIDE:
			if GlobalInfo.glide_active == true:
				get_parent().queue_free()
	body_entered.connect(_item_pickup)

func _item_pickup(body: Node2D) -> void:
	if body is Player:
		body.activate_collectable(collectable_type)
		get_parent().queue_free()
