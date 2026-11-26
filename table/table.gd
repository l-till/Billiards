# table.gd
extends RigidBody3D

signal ball_potted(ball: Node3D)

func _ready() -> void:
	for pocket in $Pockets.get_children():
		pocket.body_entered.connect(_on_pocket_body_entered)
	$CatchFloor.body_entered.connect(_on_pocket_body_entered)

func _on_pocket_body_entered(body: Node3D) -> void:
	if not (body.is_in_group("cue_ball") or body.is_in_group("object_ball")):
		return
	if body.is_queued_for_deletion():
		return
	ball_potted.emit(body)
