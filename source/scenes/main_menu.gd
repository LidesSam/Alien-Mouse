extends Control

func _ready() -> void:
	ScreenTransition.play_intro_once("fill_up")
func _on_play_btn_pressed() -> void:
	ScreenTransition.change_scene_to_file("res://source/scenes/gameroom.tscn")
