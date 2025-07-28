class_name GravityComponent
extends Node

@onready var fall_gravity: float = ((-2.0 * LAUNCH_HEIGHT) / pow(LAUNCH_TIME_TO_DESCENT,2)) * -1.0
@onready var launch_gravity: float = ((-2.0 * LAUNCH_HEIGHT) / pow(LAUNCH_TIME_TO_PEAK,2)) * -1.0


const LAUNCH_HEIGHT: float = 75.0
const LAUNCH_TIME_TO_PEAK: float = 0.5
const LAUNCH_TIME_TO_DESCENT: float = 0.45

func apply_launch_gravity() -> float:
	return launch_gravity


func apply_fall_gravity() -> float:
	return fall_gravity


func apply_launch_velocity(max_height_percent:float = 1.0) -> float:
	var launch_velocity: float = ((2.0 * (LAUNCH_HEIGHT * max_height_percent)) / LAUNCH_TIME_TO_PEAK) * -1.0
	return launch_velocity


func apply_custom_gravity(launch_height:float, time_to_reach_point:float) -> float:
	var custom_gravity: float = ((-2.0 * launch_height) / pow(time_to_reach_point,2)) * -1.0
	return custom_gravity


func apply_custom_launch_velocity(launch_height:float, time_to_reach_point:float) -> float:
	var custom_launch_velocity: float = ((2.0 * launch_height) / time_to_reach_point) * -1.0
	return custom_launch_velocity
