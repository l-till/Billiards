# cue.gd
extends RigidBody3D

@export var move_speed := 1.0         # m/s, WASD
@export var turn_speed := 1.5         # rad/s, arrow keys
@export var max_strike_speed := 6.0   # m/s at full charge
@export var charge_time := 1.5        # seconds to full power

var yaw := 0.0
var charge := 0.0
var striking := false

func _physics_process(delta: float) -> void:
	if striking:
		return

	var move := Input.get_vector("cue_left", "cue_right", "cue_forward", "cue_back")
	linear_velocity = Vector3(move.x, 0, move.y) * move_speed

	yaw -= Input.get_axis("rotate_left", "rotate_right") * turn_speed * delta

	if Input.is_action_pressed("strike"):
		charge = min(charge + delta / charge_time, 1.0)
	elif Input.is_action_just_released("strike") and charge > 0.0:
		_strike()

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	state.transform = Transform3D(Basis(Vector3.UP, yaw), state.transform.origin)

func _strike() -> void:
	striking = true
	var forward := Basis(Vector3.UP, yaw) * Vector3.FORWARD
	linear_velocity = forward * max_strike_speed * charge
	charge = 0.0
	await get_tree().create_timer(0.3).timeout
	linear_velocity = Vector3.ZERO
	striking = false
