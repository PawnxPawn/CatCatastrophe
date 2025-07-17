extends AnimatedSprite2D

@export var speed: float = 120.0

#region Components
@onready var movement_component: MovementComponent = $MovementComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent
#endregion

var is_moving: bool = true

func _ready() -> void:
	hitbox_component.hitbox_hit.connect(projectile_hit)
	animation_finished.connect(hit_animation_finished)


func _physics_process(delta: float) -> void:
	var move_direction:float = -1.0 if !flip_h else 1.0
	if is_moving:
		movement_component.handle_projectile_movement(self, speed, move_direction, delta)


func projectile_hit() -> void:
	is_moving = false
	play("hit")


func hit_animation_finished(anim_name:StringName) -> void:
	if anim_name == &"hit":
		queue_free()
