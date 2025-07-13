class_name PlayerFall
extends State

var _direction:float

func process_physics(delta:float) -> void:
	parent.velocity.y += parent.gravity_component.apply_fall_gravity() * delta
	
	if parent.is_on_floor():
		parent.jump_componenet.jump_count = 0
		state_return(&"Idle")
	
	if parent.input_component.get_jump_input() && parent.jump_componenet.jump_count < parent.jump_componenet.current_jump_limit:
		state_return(&"Jump")
		return
	
	_direction = parent.input_component.get_direction_input()
	parent.move_component.handle_movement(parent, _direction)
