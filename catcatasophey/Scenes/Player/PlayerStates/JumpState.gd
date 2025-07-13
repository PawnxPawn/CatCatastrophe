class_name JumpState
extends State

var _direction: float = 0.0
var _initial_run: bool = true

func enter() -> void:
	_initial_run = true
	parent.jump_componenet.jump_count += 1
	parent.jump_componenet.handle_jump(parent)


func process_frame(_delta:float) -> void:
	if !parent.input_component.get_jump_held_input():
		parent.velocity.y = 0
		state_return(&"Fall")
		return
	
	if parent.input_component.get_jump_input() && parent.jump_componenet.jump_count < parent.jump_componenet.current_jump_limit && !_initial_run:
		state_return(&"Jump")
		return
	
	if parent.velocity.y > 0: 
		state_return(&"Fall")
		return
	
	if parent.is_on_floor():
		parent.jump_componenet.jump_count = 0
		state_return(&"Idle")
		return
		
		_initial_run = false


func process_physics(delta:float) -> void:
	parent.velocity.y += parent.gravity_component.apply_launch_gravity() * delta
	
	_direction = parent.input_component.get_direction_input()
	parent.move_component.handle_movement(parent, _direction)
