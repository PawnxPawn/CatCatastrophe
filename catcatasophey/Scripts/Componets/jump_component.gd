class_name JumpComponent
extends Node

@onready var fall_gravity: float = ((-2.0 * JUMP_HEIGHT) / pow(JUMP_TIME_TO_DESCENT,2)) * -1.0
@onready var jump_gravity: float = ((-2.0 * JUMP_HEIGHT) / pow(JUMP_TIME_TO_PEAK,2)) * -1.0
@onready var jump_velocity: float = ((2.0 * JUMP_HEIGHT) / JUMP_TIME_TO_PEAK) * -1.0

const MAX_JUMP_COUNT: int = 1
const JUMP_HEIGHT: float = 300.0
const JUMP_TIME_TO_PEAK: float = 0.5
const JUMP_TIME_TO_DESCENT: float = 0.5

var jump_count: int = 0

func handle_jump(body: CharacterBody2D) -> void:
	body.velocity.y = jump_velocity
