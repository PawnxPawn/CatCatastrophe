extends State

@export var death_time: float = 3.0
@export var hitbox_collision: CollisionShape2D
@export var hurtbox_collision: CollisionShape2D

var death_timer: Timer = Timer.new()

func enter() -> void:
	hitbox_collision.set_deferred("disabled", true)
	hurtbox_collision.set_deferred("disabled", true)
	parent.animation_component.handle_death_animation()
	parent.animation_component.animation_player.animation_finished.connect(enemy_died_animation_finished)
	add_child(death_timer)
	death_timer.wait_time = death_time
	death_timer.timeout.connect(body_clean_up)


func enemy_died_animation_finished(_anim_name:StringName) -> void:
	death_timer.start()


func body_clean_up() -> void:
	parent.queue_free()
