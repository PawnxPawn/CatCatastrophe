class_name DetectionAreaComponent
extends Area2D

signal player_detected(player)
signal player_left_dection()



func _ready() -> void:
	body_entered.connect(_player_detected)
	body_exited.connect(_player_left_detection)


func _player_detected(body: Node2D) -> void:
	if body is not Player: return
	player_detected.emit(body)


func _player_left_detection(body: Node2D) -> void:
	if body is not Player: return
	player_left_dection.emit()
