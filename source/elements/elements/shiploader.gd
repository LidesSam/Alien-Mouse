extends Area2D

var loaded=false
var minCharge=3
var food=0
@onready var anim:AnimatedSprite2D = $anim
func _ready() -> void:
	anim.play("default")
	Global.shiploader=self

func next_stage(stage):
	loaded=false
	minCharge=3*stage
	food=0
	anim.play("activate")
	update_charge()
	
func collect_food(player):
	food += player.get_food()
	update_charge()
	#replace for button action only and player "mouse", contact
	$loadSfx.pitch_scale=(randi()%4*0.1)+1
	$loadSfx.play()
	if(food>=minCharge):
		loaded=true
		anim.play("loaded")

func update_charge():
	$charge.text= str(food,"/",minCharge)

func isLoaded():
	return loaded

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		collect_food(body)
		



func _on_sprite_2d_animation_finished() -> void:
	match anim.animation:
		"activate":
			anim.play("idle")
	pass # Replace with function body.
