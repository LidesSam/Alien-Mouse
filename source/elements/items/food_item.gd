extends Area2D

var player=null

var spawnPoint=null
var trailPosition=Vector2(0,0)
func _ready() -> void:
	$Sprite2D.frame=randi()%3
	$AnimationPlayer.play("idle")

func _process(delta: float) -> void:
	pass

func set_trail_position(pos):
	trailPosition=pos
	var lpos=position
	position=trailPosition+Vector2(randi()%3-1*2,randi()%3-1*2)
	return lpos

func picked():
	$Sprite2D.frame=3
	$CollisionShape2D.disabled=true
	
func to_ship():
	queue_free()
	
func set_spawn_point( point):
	spawnPoint=spawnPoint
	
func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player") and !player):
		picked()
		player=body
		body.add_to_food_trail(self)
		
