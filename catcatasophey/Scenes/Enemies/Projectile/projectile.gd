extends AnimatedSprite2D

@export var speed: float = 120.0
@export var lifespan_time: float = 6.0

#region Components
@onready var movement_component: MovementComponent = $MovementComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var hitbox_component_2: HitboxComponent = $HitboxComponent2
@onready var hitbox_collision: CollisionShape2D = $HitboxComponent/CollisionShape2D
@onready var hitbox_collision_2: CollisionShape2D = $HitboxComponent2/CollisionShape2D

#endregion

var is_moving: bool = true
var lifespan_timer: Timer = Timer.new()
var custom_move:bool = false

func _ready() -> void:
	hitbox_component.hitbox_hit.connect(projectile_hit)
	hitbox_component_2.hitbox_hit.connect(projectile_hit)
	animation_finished.connect(remove_projectile)
	add_child(lifespan_timer)
	lifespan_timer.wait_time = lifespan_time
	lifespan_timer.timeout.connect(remove_projectile)
	lifespan_timer.start()


func _physics_process(delta: float) -> void:
	if is_moving:
		if custom_move:
			movement_component.handle_custom_projectile_movement(self,speed, delta)
			return
		var move_direction: float
		move_direction = -1.0 if !flip_h else 1.0
		movement_component.handle_projectile_movement(self, speed, move_direction, delta)


func projectile_hit() -> void:
	is_moving = false
	hitbox_collision.set_deferred("disabled", true)
	hitbox_collision_2.set_deferred("disabled", true)
	play("hit")


func remove_projectile() -> void:
	queue_free()
