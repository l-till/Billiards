# cue.gd
extends RigidBody3D

enum State { AIMING, STRIKING, WAITING }

@export var turn_speed := 1.0         # rad/s, arrow keys
@export var fine_turn_speed := 0.25   # rad/s, A and D for fine aim
@export var max_strike_speed := 6.0   # m/s at full charge
@export var charge_time := 1.5        # seconds to full power
@export var rest_gap := 0.03          # gap between tip and ball at rest
@export var max_pullback := 0.3       # how far the cue draws back at full charge
@export var ball_radius := 0.028575

var state := State.AIMING
var yaw := PI
var charge := 0.0

func _forward() -> Vector3:
	return Basis(Vector3.UP, yaw) * Vector3.FORWARD

func _cue_ball() -> RigidBody3D:
	return get_tree().get_first_node_in_group("cue_ball") as RigidBody3D

func _physics_process(delta: float) -> void:
	match state:
		State.AIMING:
			yaw -= Input.get_axis("rotate_left", "rotate_right") * turn_speed * delta
			yaw -= Input.get_axis("cue_left", "cue_right") * fine_turn_speed * delta
			if Input.is_action_pressed("strike"):
				charge = min(charge + delta / charge_time, 1.0)
			elif Input.is_action_just_released("strike"):
				if charge > 0.05:
					_strike()
				else:
					charge = 0.0
		State.WAITING:
			if _cue_ball() != null and _balls_stopped():
				_set_active(true)
				state = State.AIMING

func _integrate_forces(physics_state: PhysicsDirectBodyState3D) -> void:
	var basis := Basis(Vector3.UP, yaw)
	match state:
		State.AIMING:
			var ball := _cue_ball()
			if ball == null:
				return
			var gap := ball_radius + rest_gap + charge * max_pullback
			var tip_pos := ball.global_position + _forward() * gap
			physics_state.transform = Transform3D(basis, tip_pos)
			physics_state.linear_velocity = Vector3.ZERO
		State.STRIKING:
			physics_state.transform = Transform3D(basis, physics_state.transform.origin)

func _strike() -> void:
	state = State.STRIKING
	linear_velocity = -_forward() * max_strike_speed * charge
	charge = 0.0
	await get_tree().create_timer(0.4).timeout
	linear_velocity = Vector3.ZERO
	_set_active(false)
	state = State.WAITING

func _set_active(on: bool) -> void:
	$cue.visible = on
	$CollisionShape3D.set_deferred("disabled", not on)

func _balls_stopped() -> bool:
	for group in ["cue_ball", "object_ball"]:
		for ball in get_tree().get_nodes_in_group(group):
			if (ball as RigidBody3D).linear_velocity.length() > 0.02:
				return false
	return true
