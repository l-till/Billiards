# main.gd
extends Node3D

#
const BALL_DIAMETER := 0.05715

#
var cue_ball_scene: PackedScene = preload("res://balls/cue_ball.tscn")
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
@onready var table = $Table
@onready var balls_root = $Balls

#
func _ready() -> void:
	table.ball_potted.connect(_on_ball_potted)
	_spawn_cue_ball()
	_rack_balls()

func _spawn_cue_ball() -> void:
	var cue_ball = cue_ball_scene.instantiate()
	balls_root.add_child(cue_ball)
	cue_ball.global_position = table.get_node("Spawns/HeadSpot").global_position

func _rack_balls() -> void:
	var origin: Vector3 = table.get_node("Spawns/FootSpot").global_position
	var row_step := BALL_DIAMETER * 0.866   # sqrt(3)/2 spacing between rows
	var i := 0
	for row in range(5):
		for col in range(row + 1):
			var ball = ball_scenes[i].instantiate()
			balls_root.add_child(ball)
			ball.global_position = origin + Vector3(
				row * row_step,
				0,
				(col - row / 2.0) * BALL_DIAMETER
			)
			i += 1

func _on_ball_potted(ball: Node3D) -> void:
	if ball.is_in_group("cue_ball"):
		ball.queue_free()
		await get_tree().create_timer(1.0).timeout
		_spawn_cue_ball()
	else:
		ball.queue_free()
