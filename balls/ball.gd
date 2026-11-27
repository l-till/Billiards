# ball.gd
extends RigidBody3D

#
signal stopped

#
@export var is_cue_ball := false
@export var stop_speed := 0.1

#
func _ready() -> void:
	add_to_group("cue_ball" if is_cue_ball else "object_ball")

#
#func _physics_process(_delta: float) -> void:
#	if linear_velocity.length() < stop_speed and angular_velocity.length() < 0.5:
#		linear_velocity = Vector3.ZERO
#		angular_velocity = Vector3.ZERO

# handles the physics state
func _integrate_forces(state):
	# stops the ball at .1 incase it takes a long time to 0
	if state.linear_velocity.length() < 0.1:
		stopped.emit()
		state.linear_velocity = Vector3.ZERO
		state.angular_velocity = Vector3.ZERO
#	if position.y < -20:
#		get_tree().reload_current_scene()
