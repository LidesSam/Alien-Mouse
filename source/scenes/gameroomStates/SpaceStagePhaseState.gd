extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actonwer):
	super(actonwer)
	actonwer.player.awaiting=true
	actonwer.player.hide()
	actonwer.spacePhase.show()
	actonwer.spacePhase.start_phase()
	
func exit(actowner):
	actowner.spacePhase.hide()
	actowner.shiploader.next_stage()
