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
	
	parent.animation_component._handle_idle_animation()


func process_frame(_delta:float) -> void:
	#TODO: Detect area detects player switch to alert state
	pass

func process_physics(delta:float) -> void:
	if !parent.is_on_floor():
		parent.velocity.y += parent.gravity_component.apply_fall_gravity() * delta

func idle_timeout() -> void:
	if !parent.disable_walk:
		state_return(&"Walk")


func exit() -> void:
	remove_child(idle_timer)
	idle_timer.timeout.disconnect(idle_timeout)
