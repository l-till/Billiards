# ball.gd
extends RigidBody3D

#signals
#signal stopped

#
@export var is_cue_ball := false
@export var stop_speed := 0.02

#
func _ready() -> void:
	add_to_group("cue_ball" if is_cue_ball else "object_ball")

#
func _physics_process(_delta: float) -> void:
	if linear_velocity.length() < stop_speed and angular_velocity.length() < 0.5:
		linear_velocity = Vector3.ZERO
		angular_velocity = Vector3.ZERO
