extends State

@onready var idle_timer: Timer = Timer.new()

@export var ground_detection_l: RayCast2D
@export var ground_detection_r: RayCast2D
@export var walk_disabled: bool = false


func enter() -> void:
	parent.velocity.x = 0.0
	var random_time:float = randf_range(1.0, 5.0)
	add_child(idle_timer)
	idle_timer.one_shot = true
	idle_timer.wait_time = random_time
	idle_timer.timeout.connect(idle_timeout)
	idle_timer.start()
	
	parent.stats.damage_taken.connect(enemy_damaged)
	parent.line_of_sight_component.player_in_sight.connect(player_detected)
	parent.animation_component._handle_idle_animation()

func process_physics(delta:float) -> void:
	if !parent.is_on_floor():
		parent.velocity.y += parent.gravity_component.apply_fall_gravity() * delta

func idle_timeout() -> void:
	if !parent.disable_walk:
		state_return(&"Walk")
		return
	state_return(&"Idle")


func player_detected() -> void:
	state_return(&"Alerted")


func enemy_damaged() -> void:
	state_return(&"Hurt")


func exit() -> void:
	remove_child(idle_timer)
	idle_timer.timeout.disconnect(idle_timeout)
	parent.stats.damage_taken.disconnect(enemy_damaged)
	parent.line_of_sight_component.player_in_sight.disconnect(player_detected)
