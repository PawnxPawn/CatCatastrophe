class_name PlayerWalk
extends State

var _direction:float = 0.0
var g = Globals

func enter() -> void:
	parent.move_component.set_speed(g.MovementType.WALK)
	parent.animation_component.handle_move_animation(parent.input_component.get_direction_input())

func process_input(_event: InputEvent) -> void:
	if parent.input_component.get_run_input():
		state_return(&"Run")


func process_frame(_delta: float) -> void:
	_direction = parent.input_component.get_direction_input()
	
	parent.animation_component.handle_move_animation(_direction)
	
	if _direction == 0.0:
		state_return(&"Idle")
		return
	
	if !parent.is_on_floor():
		state_return(&"Fall")
		return
	
	if parent.input_component.get_jump_input():
		state_return(&"Jump")
		return
		
	parent.move_component.handle_movement(parent, _direction)
	
