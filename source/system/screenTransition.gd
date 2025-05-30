extends CanvasLayer

var on=false
var next
var firstTime=true

func change_scene_to_file(target)->void:
	$AudioStreamPlayer.play()
	$anim/blackout.material = Global.currentShadder
	$anim.play("fill_up")
	on=true
	next=target

func _on_anim_animation_finished(anim_name):
	if(on):
		on=false
		get_tree().change_scene_to_file(next)
		$anim.play_backwards(anim_name)

func play_intro_anim(anim_name):
	$anim/blackout.material = Global.currentShadder
	$anim.play_backwards(anim_name)
	
func play_intro_once(anim_name):
	if(firstTime):
		firstTime=false
		play_intro_anim(anim_name)
