extends "res://addons/fsmgear/source/FsmState.gd"


func enter(actowner):
	super(actowner)
	Musicbox.start_play()
	actowner.player.awaiting=false
	actowner.tilemap.material=actowner.stageShadder[actowner.stage]
	actowner.bg.material=actowner.stageShadder[actowner.stage]
	actowner.stage+=1
	if(actowner.stage<=3):
		actowner.player.show()
		actowner.countdownback.hide()
		actowner.timeleft.start(20)
		actowner.shiploader.next_stage(actowner.stage)
		actowner.spawn_food()
	else:
		actowner.victory=true
func update(actowner,delta):
		actowner.spawn_food()
func exit(actowner):
	super(actowner)
	actowner.timeleft.stop()
