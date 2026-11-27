# main.gd
extends Node3D

# Cameras
@onready var overview_camera: Camera3D = $Camera3D
@onready var aiming_camera: Camera3D = $Cue/Camera3D

# Ball container
@onready var balls_container: Node3D = $Balls


func _ready() -> void:
	# Start with the overview camera
	overview_camera.make_current()

	# Register balls into groups
	_setup_ball_groups()


func _process(_delta: float) -> void:
	# Switch cameras
	if Input.is_action_just_pressed("switch_camera"):
		_switch_camera()


func _switch_camera() -> void:
	if overview_camera.is_current():
		aiming_camera.make_current()
	else:
		overview_camera.make_current()


func _setup_ball_groups() -> void:
	for ball in balls_container.get_children():

		if ball.name == "CueBall":
			ball.add_to_group("cue_ball")
		else:
			ball.add_to_group("object_ball")
