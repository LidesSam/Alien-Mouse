extends "res://addons/fsmgear/source/FsmState.gd"


func enter(actowner):
	super(actowner)
	actowner.timeleft.stop()
	#actowner.player.timeover()
	#actowner.endPopupLbl.text = "You Loss... Try Again..."
	actowner.endPopup.show()#move this toprocesss 
	actowner.hud.hide()
	Musicbox.stop()
	
func update(actowner,delta):
	super(actowner,delta)
	#here check if anim finished and then show the endpopup
