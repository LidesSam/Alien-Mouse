extends "res://addons/fsmgear/source/FsmState.gd"


func enter(actowner):
	$Timer.start()
	actowner.animation.play("hurt")
	if($dmgsfx):
		$dmgsfx.pitch_scale= (randi()%5)*0.1+1
		$dmgsfx.play()
	
func dmgTimeOver():
	return $Timer.is_stopped()

func exit(actowner):
	$Timer.stop()
	actowner.damaged=false
	actowner.animation.play("down")
	
