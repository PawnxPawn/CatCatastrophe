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
	if !parent.in_alert_mode:
		walk_timer.start()
	parent.move_component.set_speed(Globals.MovementType.WALK)
	parent.animation_component.handle_move_animation(random_direction)
	parent.stats.damage_taken.connect(enemy_damaged)
	parent.line_of_sight_component.player_in_sight.connect(player_detected)


func process_physics(delta: float) -> void:
	if !parent.is_on_floor():
		parent.velocity.y += parent.gravity_component.apply_fall_gravity() * delta

	patrol(delta)


func alert_follow(_delta) -> void:
	var direction = (parent.player_position.x - parent.global_position.x) * -1
	parent.animation_component.flip_sprite(direction)
	
	if !ground_detection_l.is_colliding() and parent.player_position < parent.global_position:
		parent.move_component.handle_movement(parent, 0.0)
		return
	elif  !ground_detection_r.is_colliding() and parent.player_position > parent.global_position:
		parent.move_component.handle_movement(parent, 0.0)
		return
	
	if parent.get_wall_normal().x < 0.0 and parent.player_position < parent.global_position:
		parent.move_component.handle_movement(parent, 0.0)
		return
	elif parent.get_wall_normal().x > 0.0 and parent.player_position > parent.global_position:
		parent.move_component.handle_movement(parent, 0.0)
		return
	
	parent.move_component.handle_movement(parent, direction)
	


func patrol(_delta: float) -> void:
	if !ground_detection_l.is_colliding():
		random_direction = 1.0
	elif  !ground_detection_r.is_colliding():
		random_direction = -1.0
	if parent.is_on_wall():
		random_direction *= -1
	parent.animation_component.flip_sprite(random_direction)
	parent.move_component.handle_movement(parent, random_direction)


func enemy_damaged() -> void:
	state_return(&"Hurt")


func timer_timeout() -> void:
	state_return(&"Idle")


func player_detected() -> void:
	if !parent.in_alert_mode:
		state_return(&"Alerted")
		return
	state_return(&"Attack")


func exit() -> void:
	remove_child(walk_timer)
	walk_timer.stop()
	walk_timer.timeout.disconnect(timer_timeout)
	parent.stats.damage_taken.disconnect(enemy_damaged)
	parent.line_of_sight_component.player_in_sight.disconnect(player_detected)
