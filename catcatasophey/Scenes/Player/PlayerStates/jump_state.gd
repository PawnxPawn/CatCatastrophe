class_name JumpState
extends State

var _direction: float = 0.0
var _initial_run: bool = true
var jump_timer: Timer = Timer.new()
var jump_time: float = 0.2

func die() -> void: state_return(&"Die")
func player_damaged() -> void: state_return(&"Hurt")

func enter() -> void:
	_initial_run = true
	parent.jump_componenet.jump_count += 1
	parent.jump_componenet.handle_jump(parent)
	parent.animation_component.handle_jump_animation()
	parent.stats.damage_taken.connect(player_damaged)
	parent.stats.dead.connect(die)
	jump_timer.one_shot = true
	jump_timer.wait_time = jump_time
	add_child(jump_timer)
	jump_timer.start()


func process_input(_event: InputEvent) -> void:
	if parent.input_component.get_jump_input() && parent.jump_componenet.jump_count < parent.jump_componenet.current_jump_limit && !_initial_run && parent.abilities.double_jump_activated:
		state_return(&"Jump")
		return


func process_frame(_delta:float) -> void:
	_direction = parent.input_component.get_direction_input()
	parent.move_component.handle_movement(parent, _direction)
	parent.animation_component.flip_sprite(_direction)
	
	if !parent.input_component.get_jump_held_input() and jump_timer.is_stopped():
		parent.velocity.y = 0.0
		state_return(&"Fall")
		return
	
	if parent.velocity.y > 0.1:
		if parent.input_component.get_jump_held_input() && parent.abilities.glide_activated:
			state_return(&"Glide")
			return 
		state_return(&"Fall")
		return
	
	if parent.is_on_floor():
		if parent.input_component.get_crouch_held_input():
			state_return(&"Crouch" if !parent.input_component.get_direction_input() else &"Roll")
			return
		if parent.input_component.get_direction_input():
			state_return(&"Walk" if !parent.input_component.get_run_input() else &"Run")
			return
		
	_initial_run = false


func process_physics(delta:float) -> void:
	parent.velocity.y += parent.gravity_component.apply_launch_gravity() * delta


func exit() -> void:
	remove_child(jump_timer)
	parent.stats.damage_taken.disconnect(player_damaged)
	parent.stats.dead.disconnect(die)
