extends Node2D

@onready var player = $extraElements/mouse
@onready var shiploader = $extraElements/shiploader
@onready var spacePhase = $spacePhase
@onready var tilemap= $TileMap
@onready var fsm = $fsm


@onready var timeleft = $hud/timeleft

@onready var countdown = $hud/backCountdown/countdown
@onready var countdownback =$hud/backCountdown
@onready var countdownLbl =$hud/backCountdown/label

@onready var endPopup = $gameover
@onready var lifebar = $poinbar
var foodTemp=load("res://source/elements/items/food-item.tscn")
var stage=0

var spawnedPoints = []
var freeSpawnedPoints = []

func _ready():
	fsm.autoload(self)
	fsm.addStateTransition("startStage","platformStage",isCoundownOver)
	fsm.addStateTransition("platformStage","spaceStage",shiploader.isLoaded)
	fsm.addStateTransition("spaceStage","platformStage",spacePhase.phase_ended)
	fsm.addGlobalTransition("lossStage",lifebar.is_empty)
	fsm.startState()
	spawnedPoints =  get_spawn_point_tiles()
	freeSpawnedPoints = spawnedPoints.duplicate()
	freeSpawnedPoints.shuffle()
	
func get_spawn_point_tiles():
	var spawn_source_id = 4
	var spawn_tile_id = 1
	var spawn_positions = []

	for cell in tilemap.get_used_cells():  # Assuming layer 0
		var cell_source_id = tilemap.get_cell_source_id(cell)
		var cell_tile_id = tilemap.get_cell_alternative_tile( cell)

		if cell_source_id == spawn_source_id and cell_tile_id == spawn_tile_id:
			var world_pos = tilemap.map_to_local(cell)
			spawn_positions.append(world_pos)

	return spawn_positions

func spawn_food():
	
	while $extraElements/food.get_child_count()<3:
		var fi = foodTemp.instantiate()
		if(freeSpawnedPoints.size()<=0):
			freeSpawnedPoints = spawnedPoints.duplicate()
			freeSpawnedPoints.shuffle()
		var spawn = freeSpawnedPoints.pop_front()
		fi.global_position= spawn
		$extraElements/food.add_child(fi)
		
func isCoundownOver():
	return countdown.is_stopped()

func _process(delta: float) -> void:
	fsm.fsmUpdate(delta)

func  gameover():
	$gameover.show()

func _on_back_btn_pressed() -> void:
	ScreenTransition.change_scene_to_file("res://source/scenes/mainMenu.tscn")
	pass # Replace with function body.


func _on_replay_btn_pressed() -> void:
	ScreenTransition.change_scene_to_file("res://source/scenes/gameroom.tscn")
	pass # Replace with function body.


func _on_poinbar_lpchange() -> void:
	$hud/lbllp.text=str(lifebar.gp,"/",lifebar.maxGp)
	pass # Replace with function body.


func _on_timeleft_timeout() -> void:
	lifebar.deplete(1)
	timeleft.start(5)
	pass # Replace with function body.
