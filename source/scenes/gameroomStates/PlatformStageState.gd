extends "res://addons/fsmgear/source/FsmState.gd"


func enter(actowner):
	super(actowner)
	actowner.player.awaiting=false
	actowner.stage+=1
	if(actowner.stage<=3):
		actowner.player.show()
		actowner.countdownback.hide()
		actowner.timeleft.start(20)
	else:
		actowner.victory=true

func exit(actowner):
	super(actowner)
	actowner.timeleft.stop()
