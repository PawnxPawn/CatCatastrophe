class_name StateMachine extends Node

@export var starting_state: State

var _state_list:Array[State]
var get_state_list:Array[State]:
	get:
		return _state_list

var _current_state: State = null
var get_current_state: State:
	get:
		return _current_state

var _last_state: State = null
var get_last_state: State:
	get:
		return _last_state

var _next_state: State = null
var get_next_state: State:
	get:
		return _next_state

func init(parent: Node) -> void:
	for child in get_children():
		if child is State:
			_state_list.push_back(child)
			child._set_params(self, parent)
	
	if not starting_state:
		starting_state = _state_list[0]
	change_state(starting_state)

func change_state(new_state: State) -> void:
	if not new_state:
		push_error("Current State: %s NOT FOUND" % new_state.name)
	
	_next_state = new_state
	
	if _current_state:
		_current_state.exit()
	
	_last_state = _current_state
	_next_state = null
	
	_current_state = new_state
	if get_parent() is Player:
		print(_current_state.name)
	_current_state.enter()

func process_input(event: InputEvent) -> void:
	_current_state.process_input(event)

func process_physics(delta: float) -> void:
	_current_state.process_physics(delta)

func process_frame(delta: float) -> void:
	_current_state.process_frame(delta)
