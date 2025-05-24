extends CharacterBody2D

@onready var animation=$AnimatedSprite2D
@onready var colliderShape=$CollisionShape2D

func _ready() -> void:
	release()
func mark():
	animation.play("bump")	
	
func trigger():
	animation.play("bump")	
	
	
func release():
	animation.play("idle")	
	colliderShape.disabled=true

func _on_animated_sprite_2d_animation_finished() -> void:
	if(animation.animation=="bump"):
		colliderShape.disabled=false
	pass # Replace with function body.
