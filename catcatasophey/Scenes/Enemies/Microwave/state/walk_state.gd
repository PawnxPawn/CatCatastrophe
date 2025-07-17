extends State

@onready var walk_timer: Timer = Timer.new()
@export var ground_detection_l: RayCast2D
@export var ground_detection_r: RayCast2D

var random_direction: float

func enter() -> void:
	add_child(walk_timer)
	var random_walk_time: float = randf_range(0.5, 3.0)
	random_direction = sign(randf_range(-1, 1))
	walk_timer.wait_time = random_walk_time
	walk_timer.one_shot = false
	walk_timer.timeout.connect(timer_timeout)
	walk_timer.start()
	parent.move_component.set_speed(Globals.MovementType.WALK)
	parent.animation_component.handle_move_animation(random_direction)


func process_physics(delta: float) -> void:
	if !parent.is_on_floor():
		parent.velocity.y += parent.gravity_component.apply_fall_gravity() * delta
	if !ground_detection_l.is_colliding():
		random_direction = 1.0
	elif  !ground_detection_r.is_colliding():
		random_direction = -1.0
	if parent.is_on_wall():
		random_direction *= -1
	parent.animation_component.flip_sprite(random_direction)
	parent.move_component.handle_movement(parent, random_direction)


func timer_timeout() -> void:
	var random_state = 0
	match random_state:
		0:
			state_return(&"Idle")
		1:
			state_return(&"Walk")


func exit() -> void:
	remove_child(walk_timer)
	walk_timer.stop()
	walk_timer.timeout.disconnect(timer_timeout)
