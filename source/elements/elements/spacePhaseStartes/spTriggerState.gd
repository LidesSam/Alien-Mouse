extends "res://addons/fsmgear/source/FsmState.gd"

@onready var restTime= $tTimer

func enter(actowner):
	super(actowner)
	actowner.gridzone.trigger_marked()
	restTime.start()
	
func exit(actowner):
	super(actowner)

func rest_over():
	return restTime.is_stopped()
