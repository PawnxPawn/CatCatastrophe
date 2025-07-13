class_name Player
extends CharacterBody2D

@onready var state_machine: StateMachine = $StateMachine

#region Resources
@export var stats: Resource
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
