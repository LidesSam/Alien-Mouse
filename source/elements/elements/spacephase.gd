extends Node2D

var start=false
var wave=0 #unused for the moment
var atk=0

@onready var fsm = $fsm
@onready var gridzone= $gridzone
@onready var player=$ship

var stage =1

func _ready() -> void:
	fsm.autoload(self)
	fsm.set_debug_on($lblstate)
	fsm.addGlobalTransition("wait",phase_ended)
	fsm.addStateTransition("wait","start",phase_started)
	fsm.addStateTransition("start","warning",$fsm/start.state_ended)
	fsm.addStateTransition("warning","trigger",$fsm/warning.warning_over)
	fsm.addStateTransition("trigger","warning",$fsm/trigger.rest_over)
	
	fsm.startState()
	
	
func _process(delta: float) -> void:
	fsm.fsmUpdate(delta)

func start_phase():
	gridzone.hide()
	$AnimationPlayer.play("OpenSpace")
	start=true
	
func end_phase():
	start=false
	
func phase_started():
	return start==true and !$AnimationPlayer.is_playing()
	
func phase_ended():
	return start==false
