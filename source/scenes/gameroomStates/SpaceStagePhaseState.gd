extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	super(actowner)
	actowner.player.awaiting=true
	actowner.player.hide()
	actowner.spacePhase.show()
	actowner.spacePhase.stage = actowner.stage
	actowner.spacePhase.start_phase()
	
func exit(actowner):
	actowner.spacePhase.hide()
	
