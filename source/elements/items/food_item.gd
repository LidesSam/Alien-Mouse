extends Area2D

@onready var follow=false
var player=null


func _process(delta: float) -> void:
	pass

func picked():
	$CollisionShape2D.disabled=true
	
func to_ship():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		picked()
		body.foodTrail.push_back(self)
