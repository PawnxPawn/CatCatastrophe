class_name Stats
extends Resource 

@export var character_name: StringName

@export_group("Values")
@export var max_health: int = 100
@export var max_stamina: int = 100

var health: int = max_health:
	set(value):
		health = clampi(value, 0, max_health)
		print (health)

var stamina: int = max_stamina:
	set(value):
		stamina = clampi(value, 0, max_stamina)
