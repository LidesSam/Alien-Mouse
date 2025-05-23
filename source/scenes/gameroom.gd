extends Node2D

@onready var player = $mouse
@onready var tilemap= $TileMap
@onready var fsm = $fsm



func _ready():
	player.set_tilemap(tilemap)
	player.awaiting = false
	pass
