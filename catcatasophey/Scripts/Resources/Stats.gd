class_name CharacterStats
extends Resource 

@export_group("Values")
@export var max_health: int = 3

var health: int = max_health:
	set(value):
		health = clampi(value, 0, max_health)
		print_debug()
		print (health)
