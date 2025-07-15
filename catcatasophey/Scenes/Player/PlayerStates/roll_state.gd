class_name RollState
extends State

@export var ceiling_check_left: RayCast2D
@export var ceiling_check_right: RayCast2D
var _direction: float = 0.0

func enter() -> void: 
	parent.animation_component.handle_roll_animation()
	parent.cat_collision.disabled = true
	parent.cat_roll_collision.disabled = false
	ceiling_check_left.enabled = true
	ceiling_check_right.enabled = true


func process_input(_event: InputEvent) -> void:
	if parent.input_component.get_jump_input():
		state_return(&"Jump")
		return


func process_frame(_delta: float) -> void:
	_direction = parent.input_component.get_direction_input()
	parent.move_component.handle_movement(parent, _direction)
	parent.animation_component.flip_sprite(_direction)
	parent.animation_component.handle_roll_animation()
	
	if parent.input_component.get_run_input():
		parent.move_component.set_speed(Globals.MovementType.RUN)
	else:
		parent.move_component.set_speed(Globals.MovementType.WALK)
	
	if !parent.is_on_floor():
		state_return(&"Fall")
		return
	
	 
	if !parent.input_component.get_crouch_held_input() and !check_ceiling_collision():
		if parent.input_component.get_direction_input():
			state_return(&"Walk" if !parent.input_component.get_run_input() else &"Run")
			return
		state_return(&"Idle")
		return
	
	if !_direction and !check_ceiling_collision():
		state_return(&"Crouch")
		return


func check_ceiling_collision() -> bool:
	return ceiling_check_left.is_colliding() or ceiling_check_right.is_colliding()

func exit() -> void:
	parent.cat_collision.disabled = false
	parent.cat_roll_collision.disabled = true
	ceiling_check_left.enabled = false
	ceiling_check_right.enabled = false
