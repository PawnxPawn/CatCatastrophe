class_name Checkpoint
extends AnimatedSprite2D

@export var is_first_checkpoint: bool = false

@onready var checkpoint_area: Area2D = $CheckpointArea

func _ready() -> void:
	checkpoint_area.body_entered.connect(change_crate_state)
	if is_first_checkpoint and GlobalInfo.active_checkpoint == Vector2.ZERO:
		frame = 1
		GlobalInfo.active_checkpoint = global_position
		GlobalInfo.active_checkpoint_node = self
	SignalBus.emit_signal_bus(SignalBus.SignalTypes.SET_PLAYER_SPAWN)

func change_crate_state(body:Node2D) -> void:
	if !body is Player: return
	if frame == 0:
		frame = 1
		if GlobalInfo.active_checkpoint_node != null:
			GlobalInfo.active_checkpoint_node.frame = 0
		GlobalInfo.active_checkpoint_node = self
		GlobalInfo.active_checkpoint = global_position
