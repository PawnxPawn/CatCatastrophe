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


func activate_collectable(ability_type:Globals.CollectableTypes) -> void:
	match ability_type:
		Globals.CollectableTypes.JUMP:
			if !abilities.jump_activated:
				abilities.jump_activated = true
			else:
				abilities.double_jump_activated = true
		Globals.CollectableTypes.ROLL:
			abilities.roll_activated = true
		Globals.CollectableTypes.RUN:
			abilities.run_activated = true
		Globals.CollectableTypes.ATTACK:
			abilities.attack_activated = true
		Globals.CollectableTypes.GLIDE:
			abilities.glide_activated = true
		Globals.CollectableTypes.YARN:
			stats.yarn_collected += 1
