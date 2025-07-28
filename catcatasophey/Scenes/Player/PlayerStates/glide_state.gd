extends State

const VELOCITY_HEIGHT: float = 65.0
const TIME_TO_DECENT: float = 15.0
func die() -> void: state_return(&"Die")
func player_damaged() -> void: state_return(&"Hurt")

func enter() -> void:
	parent.velocity.y = 0.0
	parent.animation_component.handle_glide_animation()
	parent.stats.damage_taken.connect(player_damaged)
	parent.stats.dead.connect(die)
	parent.nyon_rainbow.visible = true

func process_physics(_delta:float) -> void:
	parent.velocity.y += parent.gravity_component.apply_custom_gravity(VELOCITY_HEIGHT, TIME_TO_DECENT)
	
	var _direction = parent.input_component.get_direction_input()
	parent.move_component.handle_movement(parent, _direction)
	parent.animation_component.flip_sprite(_direction)
	
	if !parent.input_component.get_jump_held_input():
		state_return(&"Fall")
	
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
	parent.nyon_rainbow.visible = false
