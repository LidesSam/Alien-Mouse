extends "res://addons/fsmgear/source/FsmState.gd"



func enter(actowner):
	super(actowner)
	actowner.animation.play("dmg")
	actowner.velocity=Vector2.ZERO
	if($dmgsfx):
		$dmgsfx.play()
		$dmgsfx.pitch_scale= 1.0 + (randi()%5-2)*0.2
	
func handleInput(actowner,event):
	super(actowner,event)
	

func update(actowner,delta):
	super(actowner,delta)
		
func exit(actowner):
	super(actowner)
