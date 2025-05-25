extends CharacterBody2D

var d=-1

var speed=200

var gpos=Vector2(4,4)
var gridOffset=Vector2(16,16)
var gridzone =null
var death=false
var dying=false
var damaged=false
var awaiting = true
var move = true

#lifepoints
var lifebar = null

@onready var fsm = $fsm
@onready var animation=$AnimatedSprite2D

func _ready() -> void:
	fsm.autoload(self)
	
	fsm.addStateTransition("wait","idle",isNotAwaiting)
	fsm.addGlobalTransition("die",isDying)
	
	fsm.addStateTransition("idle","damage", isDamaged)
	fsm.addStateTransition("damage","idle",$fsm/damage.dmgTimeOver)
	
	fsm.set_debug_on($Label)
	fsm.startState()
func isDamaged():
	return damaged
func _process(delta: float) -> void:
	fsm.fsmUpdate(delta)
	
func _input(event):		
	fsm.handleInput(event)
	
		
func move_input():
	#if(move):
		print("ship:mp:",gpos)
		if Input.is_action_just_pressed("ui_right"):
			move_to_cell(gpos + Vector2.RIGHT)
			animation.play("right")
		elif Input.is_action_just_pressed("ui_left"):
			move_to_cell(gpos + Vector2.LEFT)
			animation.play("left")
		elif Input.is_action_just_pressed("ui_up"):
			move_to_cell(gpos + Vector2.UP)
			animation.play("up")
		elif Input.is_action_just_pressed("ui_down"):
			move_to_cell(gpos + Vector2.DOWN)
			animation.play("down")

func move_to_cell(target_cell: Vector2):
	
	print("ship:gpos:",gpos)
	gpos = target_cell
	print("ship:gpos:",gpos)
	set_Grid_Pos()

func set_Grid_Pos():
	# Clamp grid position within bounds
	gpos.x = clamp(gpos.x, 0, gridzone.gridsize.x - 1)
	gpos.y = clamp(gpos.y, 0, gridzone.gridsize.y - 1)

	# Apply movement to node position
	position = gpos * 32+gridOffset

	# Restart movement cooldown timer
	move = false
	$moveTimer.start()

	# Update parent node display
#	get_parent().update_data_display()

func get_Grid_Pos():
	return gpos

func isDying():
	return dying

func isNotAwaiting():
	return !awaiting

#----
func wait_over():
	awaiting=false
	
func set_lifebar(bar):
	lifebar = bar

func hurt(points:int=1):	
	lifebar.deplete(points)
	damaged=true
	
func _on_move_timer_timeout() -> void:
	move = true  # Re-enable movement after timer delay
