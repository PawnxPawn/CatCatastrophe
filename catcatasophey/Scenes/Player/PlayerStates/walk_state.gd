class_name PlayerWalk
extends State

var coyotte_time: float = 0.05

var _direction:float = 0.0
var g = Globals
var coyotte_timer: Timer = Timer.new()

func die() -> void: state_return(&"Die")

func enter() -> void:
	parent.move_component.set_speed(g.MovementType.WALK)
	parent.animation_component.handle_move_animation(parent.input_component.get_direction_input())
	parent.stats.damage_taken.connect(player_damaged)
	parent.stats.dead.connect(die)
	
	coyotte_timer.wait_time = coyotte_time
	coyotte_timer.one_shot = true
	coyotte_timer.timeout.connect(coyotte_timer_timeout)
	add_child(coyotte_timer)

func process_input(_event: InputEvent) -> void:
	if parent.input_component.get_run_input():
		state_return(&"Run")
		return
	
	if parent.input_component.get_jump_input():
		state_return(&"Jump")
		return
	
	if parent.input_component.get_crouch_held_input():
		state_return(&"Roll")
		return
	
	if parent.input_component.get_attack_input():
		state_return(&"Attack")
		return


func process_frame(_delta: float) -> void:
	_direction = parent.input_component.get_direction_input()
	
	parent.animation_component.handle_move_animation(_direction)
	
	if _direction == 0.0:
		state_return(&"Idle")
		return
	
	if parent.is_on_floor():
		coyotte_timer.stop()
	
	if !parent.is_on_floor() and coyotte_timer.is_stopped():
		coyotte_timer.start()
	
	parent.move_component.handle_movement(parent, _direction)
	

func player_damaged() -> void:
	state_return(&"Hurt")


func exit() -> void:
	parent.stats.damage_taken.disconnect(player_damaged)
	parent.stats.dead.disconnect(die)
	coyotte_timer.timeout.disconnect(coyotte_timer_timeout)
	remove_child(coyotte_timer)


func coyotte_timer_timeout() -> void:
	state_return(&"Fall")
	return
