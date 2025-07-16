class_name Player
extends CharacterBody2D

#region Nodes
@onready var state_machine: StateMachine = $StateMachine
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cat_collision: CollisionShape2D = %CatCollision
@onready var cat_roll_collision: CollisionShape2D = %CatRollCollision
@onready var nyon_rainbow: Sprite2D = $AnimatedSprite2D/WavyNyonRainbow
#endregion

#region Resources
@export var stats: CharacterStats
@export var abilities: Abilities
#endregion

#region Components
@onready var input_component: InputComponent = %InputComponent
@onready var move_component: MovementComponent = %MovementComponent
@onready var animation_component: AnimationComponent = %AnimationComponent
@onready var damage_component: DamageComponent = %DamageComponent
@onready var hurtbox_component: HurtboxComponent = %HurtboxComponent
@onready var jump_componenet: JumpComponent = %JumpComponent
@onready var gravity_component: GravityComponent = %GravityComponent
#endregion

var collectable:Globals.CollectableTypes

func _ready() -> void:
	state_machine.init(self)
	damage_component.init_damage_component(self, hurtbox_component)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func _process(delta: float) -> void:
	state_machine.process_frame(delta)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	move_and_slide()

func activate_ability(ability_type:Globals.CollectableTypes) -> void:
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
