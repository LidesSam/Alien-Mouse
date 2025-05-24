extends CharacterBody2D

var d=-1

var speed=200

#reftoparentNodes
var hud=null

#lifepoints
var maxlp=3
var lp=0


var death=false
var dying=false
var awaiting = true

@onready var fsm = $fsm
@onready var animation=$AnimatedSprite2D

func _ready() -> void:
	fsm.autoload(self)
	fsm.addStateTransition("wait","idle",isNotAwaiting)
	fsm.addGlobalTransition("die",isDying)
	
func move_input():
	pass
	
	


func isDying():
	return dying

func isNotAwaiting():
	return !awaiting

#----
func wait_over():
	awaiting=false
