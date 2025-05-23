extends Node2D

@onready var player = $mouse
@onready var tilemap= $TileMap
@onready var fsm = $fsm



func _ready():
	player.set_tilemap(tilemap)
	player.awaiting = false
	pass


func  gameover():
	$gameover.show()

func _on_back_btn_pressed() -> void:
	ScreenTransition.change_scene_to_file("res://source/scenes/mainMenu.tscn")
	pass # Replace with function body.


func _on_replay_btn_pressed() -> void:
	ScreenTransition.change_scene_to_file("res://source/scenes/gameroom.tscn")
	pass # Replace with function body.
