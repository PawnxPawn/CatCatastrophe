extends State

@export var min_wait_time: float = 1.0

var timer: Timer = Timer.new()

var is_alive: bool = true

func enter() -> void:
	add_child(timer)
	timer.wait_time = min_wait_time
	parent.animation_component._handle_idle_animation()
	timer.timeout.connect(switch_states)
	parent.detection_area_component.player_detected.connect(player_entered)
	parent.hurtbox_component.hurt.connect(enemy_hurt)
	parent.stats.dead.connect(defeated)
	timer.start()


func defeated() -> void:
	if parent.stats.health <= 0:
		state_return(&"Death")

func enemy_hurt(_hitbox: HitboxComponent) -> void:
	parent.animation_component.handle_damage_flash()
	


func player_entered(_player:Node2D) -> void:
	GlobalInfo.is_in_boss_room = true


func switch_states() -> void:
	if GlobalInfo.is_in_boss_room:
		state_return(&"Attack")
	else:
		state_return(&"Idle")


func exit() -> void:
	remove_child(timer)
	timer.timeout.disconnect(switch_states)
	parent.detection_area_component.player_detected.disconnect(player_entered)
	parent.hurtbox_component.hurt.disconnect(enemy_hurt)
	parent.stats.dead.disconnect(defeated)
