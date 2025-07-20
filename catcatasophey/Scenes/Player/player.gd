class_name Player
extends Character

#region Nodes
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cat_collision: CollisionShape2D = %CatCollision
@onready var cat_roll_collision: CollisionShape2D = %CatRollCollision
@onready var claw_attack: AnimatedSprite2D = %ClawAttack
@onready var hitbox_collision: CollisionShape2D = %HitboxCollision
@onready var nyon_rainbow: Sprite2D = %WavyNyonRainbow

#endregion

#region Resources
@export var stats: CharacterStats
@export var abilities: Abilities
#endregion

var collectable:Globals.CollectableTypes

func _ready() -> void:
	super()
	damage_component.init_damage_component(self, hurtbox_component)
	global_position = GlobalInfo.player_spawn_location
	SignalBus.spawn_player.connect(set_player_spawn)
	stats.dead.connect(func():%HurtboxCollision.set_deferred("disabled", true))
	check_active_abilities()


func check_active_abilities() -> void:
	abilities.jump_activated = GlobalInfo.jump_active
	abilities.double_jump_activated = GlobalInfo.double_jump_active
	abilities.roll_activated = GlobalInfo.roll_active
	abilities.run_activated = GlobalInfo.run_active
	abilities.glide_activated = GlobalInfo.glide_active
	abilities.attack_activated = GlobalInfo.attack_active

func set_player_spawn() -> void:
	global_position = GlobalInfo.player_spawn_location


func activate_collectable(ability_type:Globals.CollectableTypes) -> void:
	match ability_type:
		Globals.CollectableTypes.JUMP:
			if !abilities.jump_activated:
				abilities.jump_activated = true
				GlobalInfo.jump_active = true
			else:
				abilities.double_jump_activated = true
				GlobalInfo.double_jump_active = true
		Globals.CollectableTypes.ROLL:
			abilities.roll_activated = true
			GlobalInfo.roll_active = true
		Globals.CollectableTypes.RUN:
			abilities.run_activated = true
			GlobalInfo.run_active = true
		Globals.CollectableTypes.ATTACK:
			abilities.attack_activated = true
			GlobalInfo.attack_active = true
		Globals.CollectableTypes.GLIDE:
			abilities.glide_activated = true
			GlobalInfo.glide_active = true
		Globals.CollectableTypes.YARN:
			stats.yarn_collected += 1
