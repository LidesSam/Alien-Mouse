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
		match actowner.stage:
			1:
				actowner.gridzone.random_atk(actowner.stage)
			2:
				actowner.gridzone.col_or_row_atk(actowner.stage)
			_:
				if(randi()%2==0):
					actowner.gridzone.random_atk(actowner.stage)
				else:
					actowner.gridzone.col_or_row_atk(actowner.stage)
		#
		actowner.gridzone.col_or_row_atk(actowner.stage)
		warningTime.start()
		
func warning_over():
	return warningTime.is_stopped()
