extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal barout
signal fullbar
signal lpchange

var gp=0 #general point s
@export var maxGp = 3
@export var vulnerable = true



# Called when the node enters the scene tree for the first time.
func _ready():
	gp=maxGp
	pass # Replace with function body.
	
func set_points(maxPoints=3, points=null):
	if(maxPoints<=0):
		maxPoints=1
	maxGp=maxPoints
	if(points):
		gp=points
	else:
		points=maxGp

func fill(points):
	gp+=points
	if gp>=maxGp:
		gp=maxGp
		emit_signal("fullbar")
	
	update_hud()
	pass

func over_fill(points):
	gp+=points
	update_hud()
		
func full_refill():
	if(gp<maxGp):
		gp=maxGp
		if gp>=0:
			emit_signal("fullbar")
	update_hud()
	
func empty():
	gp=0
	update_hud()
	update_hud()
	
func deplete(points):
	print(name," v:",vulnerable)
	if(vulnerable):
		gp-=points
		if gp<=0:
			emit_signal("barout")
		update_hud()
	pass
	
#placeholders
func update_hud():
	emit_signal("lpchange")
	pass

#flag function
func is_full():
	return gp>=maxGp
	#flag function
func is_empty():
	return gp<=0
