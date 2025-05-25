extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
var DIR_LEFT = -1
var DIR_RIGHT = 1
var d=-1

var speed=200
#reftoparentNodes
var tilemap=null

#lifepoints
var lifebar = null

var death=false
var dying=false
var inJump=false
var inGround =false
var onDropDown=false
var inPecking=false
var justHitWall = false	
var awaiting = true
var win = false

@onready var fsm = $fsm
@onready var animation=$AnimatedSprite2D
@onready var sideCollisionSensor=$RayCastSide
@onready var dmgCooldown = $Timer
@onready var wasDamaged = false

var foodTrail:Array=[]


func _ready():
	animation.flip_h=true
	velocity= Vector2(0,100)
	
	fsm.set_owner(self)
	fsm.autoload(self)
	fsm.set_debug_on($lblstate)
	
	fsm.addGlobalTransition("die",isDying)
	fsm.addGlobalTransition("wait",isWaiting)
	fsm.addGlobalTransition("victory",inVictory)
	
	fsm.addStateTransition("wait","idle",isNotAwaiting)
	fsm.addStateTransition("fall","idle",isOnGround)
	
	fsm.addStateTransition("idle","fall",isFalling)
	fsm.addStateTransition("jump","fall",isFalling)
	
	fsm.addStateTransition("idle","jump",inJumping)
	
	
	fsm.startState()
	
	
func wait_over():
	awaiting=false
	
func victory():
	wait_over()
	win=true	
	
func inVictory():
	return  isNotAwaiting() and win
	
func isNotAwaiting():
	return !awaiting
func isWaiting():
	return awaiting
#state flags function
func isFalling():
	return !isOnGround() and velocity.y>0
	
func isPecking():
	return inPecking
func outPecking():
	return !inPecking
	
func isToHangOn():
	return isPecking() and hit_a_wall()
		
func hit_a_wall():
	return justHitWall	
	
func inJumping():
	return inJump

func isDying():
	return dying
	
func isOnGround():
	return inGround and !isDying()

func _physics_process(delta):
	if(!isDying()):
		if(!hit_a_wall()):
			gravity_step()
		# Update grounded state from raycast
		var raycollider = $RayCast2D.get_collider()
		inGround = raycollider != null and raycollider == tilemap

		# Move character using Godot's built-in method
		if(!hit_a_wall()):
			move_and_slide()
		
		#unused right now but gonna for a future greature
		#handle_wall_collision()
		
		# Check for collisions (e.g., item pickups)
		# Failsafe hazard check on collision position
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			handle_tilemap_collision(collision)
			
	# Run FSM logic
	fsm.fsmUpdate(delta)	
	$lblFood.text=str(foodTrail.size())

func gravity_step():
	velocity.y-=-9.8
	if(velocity.y>=200):
		velocity.y=200

#inputs
func _input(event):		
	fsm.handleInput(event)
	
func handle_tilemap_collision(collision):
	#check collision with tilemap
			var collision_pos = collision.get_position()
			var tile_pos = tilemap.local_to_map(collision_pos)
			var tile_data = tilemap.get_cell_tile_data(tile_pos)
			if tile_data:
				if(tile_data.get_custom_data("group") ):
					if tile_data.get_custom_data("group") == "hazard" and !isDying():
						print("dying:",dying)
						dying = true
						print("dying p:",dying)
	
func handle_wall_collision():
	if !hit_a_wall() and sideCollisionSensor.enabled:
			#modulate = "#ff0"  # yellow while checking
			sideCollisionSensor.force_raycast_update()
			if sideCollisionSensor.is_colliding():
				#modulate = "#f0f"  # pink when colliding
				justHitWall = true
				

	
#inputs
func jumpInput():
	if( Input.is_action_just_pressed("ui_back")):
		inJump=true
		inGround=false
		
func sidemove():
	if (Input.is_action_pressed("ui_left")):
		d=DIR_LEFT
		animation.flip_h=true 
	if (Input.is_action_pressed("ui_right")):
		d=DIR_RIGHT
		animation.flip_h=false 
	if not(Input.is_action_pressed("ui_left")) and  not(Input.is_action_pressed("ui_right")):
		velocity.x=0
	else:
		velocity.x=speed*d
	
func push_trail_position(position):
	var pos = position
	var lastpos = null
	for t in foodTrail:
		if lastpos != null:
			pos = lastpos
		lastpos = t.position
		t.position = pos
		
func set_tilemap(tmap:TileMapLayer):
	print("setting tilemap:",tmap.name)
	tilemap=tmap
	
func play_animation(animName):
	$lblanim.text= str("anim:"+animName)
	animation.play(animName)

func get_food():
	var fp= foodTrail.size()
	for f in foodTrail:
		f.to_ship()
	foodTrail=[]
	return fp
		
func set_lifebar(bar):
	lifebar = bar

func hurt(points:int=1):	
	lifebar.deplete(points)
	
func get_wasDamaged():
	return wasDamaged

func _on_Timer_timeout():
	wasDamaged=false
	


func _on_food_trail_step_timeout() -> void:
	if(velocity!=Vector2.ZERO):
		push_trail_position(position)
