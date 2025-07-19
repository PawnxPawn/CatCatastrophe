class_name Character
extends CharacterBody2D

@export var state_machine:StateMachine

#region Components
@export_group("Components")
@export var input_component: InputComponent
@export var move_component: MovementComponent
@export var animation_component: AnimationComponent
@export var damage_component: DamageComponent
@export var hurtbox_component: HurtboxComponent
@export var hitbox_component: HitboxComponent
@export var jump_componenet: JumpComponent
@export var gravity_component: GravityComponent
@export var projectile_component: ProjectileComponent
@export var knockback_componet: KnockbackComponent
@export_subgroup("AI Components")
@export var detection_area_component: DetectionAreaComponent
@export var line_of_sight_component: LineOfSightComponent

#endregion

func _ready() -> void:
	state_machine.init(self)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func _process(delta: float) -> void:
	state_machine.process_frame(delta)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	move_and_slide()
