extends Area2D

var player=null

func _process(delta: float) -> void:
	pass

func picked():
	$CollisionShape2D.disabled=true
	
func to_ship():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player") and !player):
		picked()
		player=body
		body.foodTrail.push_back(self)
