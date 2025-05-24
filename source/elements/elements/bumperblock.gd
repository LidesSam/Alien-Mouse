extends CharacterBody2D

@onready var animation=$AnimatedSprite2D
@onready var colliderShape=$CollisionShape2D

func _ready() -> void:
	animation.play("idle")
func mark():
	animation.play("bump")	
	
func trigger():
	animation.play("bump")	
	
	
func release():
	animation.play("bump")	
	colliderShape.disabled=true

func _on_animated_sprite_2d_animation_finished() -> void:
	pass # Replace with function body.
