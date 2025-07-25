class_name PlayerFall
extends State

var _direction:float
var die:Callable = func(): state_return(&"Die")
var player_damaged:Callable = func(): state_return(&"Hurt") 

func enter() -> void:
	parent.animation_component.handle_jump_animation(true)
	parent.stats.damage_taken.connect(player_damaged)
	parent.stats.dead.connect(die)


func process_input(_event: InputEvent) -> void:
	if parent.input_component.get_jump_input():
		if parent.jump_componenet.jump_count < parent.jump_componenet.current_jump_limit && parent.abilities.double_jump_activated:
			state_return(&"Jump")
			return
		if parent.input_component.get_jump_held_input() && parent.abilities.glide_activated:
			state_return(&"Glide")
			return


func process_physics(delta:float) -> void:
	parent.velocity.y += parent.gravity_component.apply_fall_gravity() * delta
	
	_direction = parent.input_component.get_direction_input()
	parent.move_component.handle_movement(parent, _direction)
	parent.animation_component.flip_sprite(_direction)
	
	if parent.is_on_floor():
		parent.jump_componenet.jump_count = 0
		if parent.input_component.get_crouch_held_input():
			state_return(&"Crouch" if !parent.input_component.get_direction_input() else &"Roll")
			return
		if parent.input_component.get_direction_input():
			state_return(&"Walk" if !parent.input_component.get_run_input() else &"Run")
			return
		state_return(&"Idle")
		return

func exit() -> void:
	parent.stats.damage_taken.disconnect(player_damaged)
	parent.stats.dead.disconnect(die)
