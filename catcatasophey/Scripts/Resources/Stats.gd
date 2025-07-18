class_name CharacterStats
extends Resource 

signal damage_taken
signal health_added
signal dead

@export_group("Values")
@export var max_health: int = 3

var last_health = max_health;

var health: int = max_health:
	set(value):
		health = clampi(value, 0, max_health)
		
		if health < last_health:
			last_health = health
			damage_taken.emit()
		if health <= 0:
			last_health = health
			dead.emit()
		if health > last_health:
			last_health = health
			health_added.emit()


var yarn_collected: int = 0:
	set(value):
		yarn_collected = value
