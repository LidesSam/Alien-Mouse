extends "res://addons/fsmgear/source/FsmState.gd"


func enter(actonwer):
	super(actonwer)
	
func handleInput(actowner,event):
	super(actowner,event)
	actowner.move_input()
