class_name BossStats
extends Resource 

signal damage_taken
signal health_added
signal dead

@export_group("Values")
@export var max_health: int = 10

var last_health:int = max_health;

var _init:bool = true

var health: int = max_health:
	set(value):
		health = clampi(value, 0, max_health)
		
		if health < last_health:
			last_health = health
			damage_taken.emit()
		if health <= 0:
			if !_init:
				last_health = health
				dead.emit()
			else:
				_init = false
		if health > last_health:
			last_health = health
			health_added.emit()


var yarn_collected: int = 0:
	set(value):
		yarn_collected = value
