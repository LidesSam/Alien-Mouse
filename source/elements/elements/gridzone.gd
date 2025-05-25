extends Node2D

@onready var blockbumperTemp=load("res://source/elements/elements/bumperblock.tscn")

@onready  var gridsize:Vector2i = Vector2i(9,9)
var grid: Array = []
var triggered : Array = []

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

func release_all():
	for col in grid:
		for bb in col:
			bb.release()
	
func trigger_marked():
	for bb in triggered:
		bb.trigger()
	triggered=[]
	$triggerSfx.play()
	
func random_atk(stage):
	$markSfx.play()
	triggered=[]
	while triggered.size() < 12*stage:
		var rx = randi() % gridsize.x
		var ry = randi() % gridsize.y
		var bb = grid[rx][ry]
		if !triggered.has(bb):
			bb.mark()
			triggered.append(bb)

func col_or_row_atk(stage):
	$markSfx.play()
	if(randi()%2==1):
		row_atk(stage)
	else:
		column_atk(stage)

func row_atk(stage):
	var rows =[]
	while rows.size()<stage*2:
		var r = randi()%gridsize.y
		if r not in rows:
			rows.append(r)

	triggered=[]
	while rows.size()>0:
		var x =rows.pop_front()
		for y in range(gridsize.y):
			var bb = grid[x][y]
			if !triggered.has(bb):
				bb.mark()
				triggered.append(bb)
				
func column_atk(stage):
	var cols =[]
	while cols.size()<stage*2:
		var r = randi()%gridsize.x
		if r not in cols:
			cols.append(r)
	triggered=[]
	while cols.size()>0:
		var y =cols.pop_front()
		for x in range(gridsize.x):
			var bb = grid[x][y]
			if !triggered.has(bb):
				bb.mark()
				triggered.append(bb)		

	
