extends Node2D

@onready var player = $extraElements/mouse
@onready var shiploader = $extraElements/shiploader
@onready var spacePhase = $spacePhase
@onready var tilemap= $TileMap
@onready var fsm = $fsm

@onready var countdown = $hud/backCountdown/countdown
@onready var countdownback =$hud/backCountdown
@onready var countdownLbl =$hud/backCountdown/label

@onready var endPopup = $gameover
@onready var lifebar = $poinbar


func _ready():
	fsm.autoload(self)
	fsm.addStateTransition("startStage","platformStage",isCoundownOver)
	fsm.addStateTransition("platformStage","spaceStage",shiploader.isLoaded)
	fsm.addStateTransition("spaceStage","platformStage",spacePhase.phase_ended)
	fsm.startState()

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
