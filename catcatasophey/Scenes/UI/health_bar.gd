extends Control

@export var player_stats: CharacterStats

@onready var health_1: AnimatedSprite2D = %Health1
@onready var health_2: AnimatedSprite2D = %Health2
@onready var health_3: AnimatedSprite2D = %Health3
@onready var health_container: HBoxContainer = $HealthContainer

func _ready() -> void:
	player_stats.damage_taken.connect(remove_health)
	player_stats.health_added.connect(show_heatlh)
	health_1.animation_finished.connect(hide_health)
	health_2.animation_finished.connect(hide_health)
	health_3.animation_finished.connect(hide_health)


func remove_health() -> void:
	if player_stats.health < 3 and health_3.visible and !health_3.is_playing():
		health_3.play(&"health3")
	if player_stats.health < 2 and health_2.visible and !health_2.is_playing():
		health_2.play(&"health2")
	if player_stats.health < 1 and health_1.visible and !health_1.is_playing():
		health_1.play(&"health1")

func hide_health() -> void:
	if player_stats.health < 3 and health_3.visible and !health_3.is_playing():
		health_3.visible = false
		health_3.frame = 0
	if player_stats.health < 2 and health_2.visible and !health_2.is_playing():
		health_2.visible = false
		health_2.frame = 0
	if player_stats.health < 1 and health_1.visible and !health_1.is_playing():
		health_1.visible = false
		health_1.frame = 0


func show_heatlh() -> void:
	if player_stats.health >= 3 and !health_3.visible:
		health_3.visible = true
	if player_stats.health >= 2 and !health_2.visible:
		health_3.visible = true
	if player_stats.health >= 1 and !health_1.visible:
		health_3.visible = true
