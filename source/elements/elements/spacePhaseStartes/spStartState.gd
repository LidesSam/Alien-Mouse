extends "res://addons/fsmgear/source/FsmState.gd"

var endstate=false
func enter(actowner):
	super(actowner)
	actowner.player.gridzone =actowner.gridzone
	actowner.wave=0
	actowner.atk=0
	actowner.player.awaiting=false
	endstate=true

func exit(actowner):
	super(actowner)
	endstate=false
func state_ended():
	return endstate==true
	
