extends Node2D

@onready var blockbumperTemp=load("res://source/elements/elements/bumperblock.tscn")

@onready  var gridsize:Vector2i = Vector2i(9,9)
var grid: Array = []
var wave=0
var atack=0

func _ready() -> void:
	# Initialize the 2D array
	grid.resize(gridsize.x)
	for x in range(gridsize.x):
		grid[x] = []
		for y in range(gridsize.y):
			var bb = blockbumperTemp.instantiate()
			bb.position = Vector2(x * 32+16, y * 32+16)  # Use Vector2 for position
			add_child(bb)
			grid[x].append(bb)
			grid[x][y]=bb

func free_all():
	for b in grid:
		b.release()
	
