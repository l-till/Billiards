# title.gd
extends Control

func _ready() -> void:
	$CenterContainer/Menu/PlayButton.grab_focus()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://main/main.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
