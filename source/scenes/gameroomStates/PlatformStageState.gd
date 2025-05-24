extends "res://addons/fsmgear/source/FsmState.gd"


func enter(actowner):
	super(actowner)
	actowner.player.awaiting=false
	actowner.player.show()
	actowner.countdownback.hide()
