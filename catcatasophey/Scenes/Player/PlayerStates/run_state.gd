class_name PlayerRun
extends State

var _direction:float
var g = Globals

func enter() -> void:
	parent.move_component.set_speed(g.MovementType.RUN)

func process_input(_event: InputEvent) -> void:
	if !parent.input_component.get_run_input():
		state_return(&"Walk")


func process_frame(_delta: float) -> void:
	parent.animation_component.handle_move_animation(_direction)


func process_physics(_delta: float) -> void:
	_direction = parent.input_component.get_direction_input()
	
	if _direction == 0.0:
		state_return(&"Idle")
	
	if !parent.is_on_floor():
		state_return(&"Fall")
	
	if parent.input_component.get_jump_input():
		state_return(&"Jump")
	
	parent.move_component.handle_movement(parent, _direction)
	
