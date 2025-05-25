extends "res://addons/fsmgear/source/FsmState.gd"


func enter(actowner):
	super(actowner)
	actowner.player.awaiting=false
	actowner.player.show()
	actowner.countdownback.hide()
	actowner.timeleft.start(20)

func exit(actowner):
	super(actowner)
	actowner.timeleft.stop()
