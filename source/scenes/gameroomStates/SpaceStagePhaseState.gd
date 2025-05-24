extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actonwer):
	super(actonwer)
	actonwer.player.awaiting=true
	actonwer.player.hide()
	actonwer.spacePhase.show()
