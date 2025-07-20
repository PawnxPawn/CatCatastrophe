class_name Checkpoint
extends AnimatedSprite2D

@export var is_first_checkpoint: bool = false

@onready var checkpoint_area: Area2D = $CheckpointArea

func _ready() -> void:
	checkpoint_area.body_entered.connect(change_crate_state)
	if is_first_checkpoint:
		frame = 1
		GlobalInfo.active_checkpoint = self
		SignalBus.emit_signal_bus(SignalBus.SignalTypes.SET_PLAYER_SPAWN)

func change_crate_state(body:Node2D) -> void:
	if !body is Player: return
	if frame == 0:
		frame = 1
		GlobalInfo.active_checkpoint.frame = 0
		GlobalInfo.active_checkpoint = self
