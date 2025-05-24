extends Area2D

var loaded=false
var minCharge=3
var food=0

func next_stage():
	loaded=false
	minCharge+=1
	food=0
	
func collect_food(player):
	food += player.get_food()
	update_charge()
	#replace for button action only and player "mouse", contact
	if(food>minCharge):
		loaded=true

func update_charge():
	$charge.text= str(food,"/",minCharge)

func isLoaded():
	return loaded

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		collect_food(body)
