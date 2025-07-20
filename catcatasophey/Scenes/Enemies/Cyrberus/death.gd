extends State

@export var explosions: Node2D



var death_timer: Timer = Timer.new()

@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var hitbox_collision: CollisionShape2D = %HitboxCollision
@onready var hitbox_collsion_2: CollisionShape2D = %HitboxCollsion2
@onready var hurtbox_collision: CollisionShape2D = %HurtboxCollision
@onready var detection_collision: CollisionShape2D = %DetectionCollision


func enter() -> void:
	GlobalInfo.is_in_boss_room = false
	collision_shape_2d.set_deferred("disabled",true)
	hitbox_collision.set_deferred("disabled",true)
	hitbox_collsion_2.set_deferred("disabled",true)
	hurtbox_collision.set_deferred("disabled",true)
	detection_collision.set_deferred("disabled",true)
	
	add_child(death_timer)
	death_timer.wait_time = 3.0
	death_timer.timeout.connect(finish)
	
	for child in explosions.get_children():
		child.play(&"explosion")
		await get_tree().create_timer(randf_range(0.3, 1.0)).timeout
	
	death_timer.start()


func finish() -> void:
	parent.call_deferred("queue_free")
