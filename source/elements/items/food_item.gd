extends CharacterBody2D

@onready var follow=false
var player=null


func _process(delta: float) -> void:
	if(follow):
		if(player):
			
			pass
	pass

func picked():
	$CollisionShape2D.disabled=true
	
