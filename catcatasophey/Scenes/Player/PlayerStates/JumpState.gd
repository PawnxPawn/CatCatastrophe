class_name JumpState
extends State

func enter() -> void:
	parent.jump_component.handle_jump()


func process_physics(delta:float) -> void:
	parent.velocity.y += parent.jump_gravity * delta
	
	if parent.velocity.y > 0: 
		state_return(&"Fall")
		return
	
	if parent.is_on_floor():
		parent.jump_componenet.jump_count = 0
		state_return(&"Idle")
		return
