extends "res://addons/fsmgear/source/FsmState.gd"
#idlestae

var downFlag=false

func enter(actowner):
	actowner.play_animation("idle")
	actowner.inJump=false
	actowner.sideCollisionSensor.enabled=false
	if($landingSfx):
		$landingSfx.play()
		$landingSfx.pitch_scale= 1.0 + (randi()%5-2)*0.2
	super(actowner)

func handleInput(actowner,event):
	super(actowner,event)
	actowner.jumpInput()
#	actowner.peckInput()
	actowner.sidemove()

func update(actowner,delta):
	super(actowner,delta)
	if(actowner.velocity.x==0):
		actowner.play_animation("idle")
	else:
		actowner.play_animation("walk")
		
func exit(actowner):
	super(actowner)
