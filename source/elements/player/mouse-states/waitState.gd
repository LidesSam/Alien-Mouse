extends "res://addons/fsmgear/source/FsmState.gd"


func enter(actowner):
	super(actowner)
	actowner.play_animation("idle")
	actowner.velocity=Vector2(0,0)
	
func update(actowner,delta):
	super(actowner,delta)
