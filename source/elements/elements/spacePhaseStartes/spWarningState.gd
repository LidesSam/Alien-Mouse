extends "res://addons/fsmgear/source/FsmState.gd"

@onready var warningTime= $wTimer

func enter(actowner):
	super(actowner)
	actowner.gridzone.release_all()
	actowner.atk+=1
	print("atk",actowner.atk)
	if(actowner.atk>3):
		actowner.end_phase()
		actowner.atk=0
	else:
		actowner.gridzone.random_atk()
		warningTime.start()
		
func warning_over():
	return warningTime.is_stopped()
