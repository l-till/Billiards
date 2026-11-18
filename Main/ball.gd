extends RigidBody3D


#signals
signal stopped


# function to handle shooting
func shoot(angle, power):
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	var force = Vector3.FORWARD.rotated(Vector3.UP, angle)
	#force.y = 0
	force = force.normalized()
	apply_central_impulse(force * power)


# handles the physics state
func _integrate_forces(state):
	# stops the ball at .1 incase it takes a long time to 0
	if state.linear_velocity.length() < 0.1:
		stopped.emit()
		state.linear_velocity = Vector3.ZERO
		state.angular_velocity = Vector3.ZERO
	if position.y < -20:
		get_tree().reload_current_scene()
