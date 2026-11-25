extends Node3D

var ball_scenes: Array[PackedScene] = [
	preload("res://balls/ball_01.tscn"),
	preload("res://balls/ball_02.tscn"),
	preload("res://balls/ball_03.tscn"),
	preload("res://balls/ball_04.tscn"),
	preload("res://balls/ball_05.tscn"),
	preload("res://balls/ball_06.tscn"),
	preload("res://balls/ball_07.tscn"),
	preload("res://balls/ball_08.tscn"),
	preload("res://balls/ball_09.tscn"),
	preload("res://balls/ball_10.tscn"),
	preload("res://balls/ball_11.tscn"),
	preload("res://balls/ball_12.tscn"),
	preload("res://balls/ball_13.tscn"),
	preload("res://balls/ball_14.tscn"),
	preload("res://balls/ball_15.tscn"),
	preload("res://balls/cue_ball.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
