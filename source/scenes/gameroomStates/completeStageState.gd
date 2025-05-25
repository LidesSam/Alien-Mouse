extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	super(actowner)
	actowner.player.show()
	actowner.player.victory()
	actowner.endPopup.get_node("Label").text="complete"
	actowner.hud.hide()
	$vitoryJingleSfx.play()
	Musicbox.stop()
	
func update(actowner,delta):
	super(actowner,delta)
	if(!actowner.player.animation.is_playing()):
		actowner.endPopup.show()
