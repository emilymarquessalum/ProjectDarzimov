extends behaviour


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _start_behaviour():
	pass
	
var db = 0
var dd = 10
func _update(d, c):
	db+= 1
	if db < dd:
		return
	db = 0
	if true:
		c._change_state("jumping")
		var p = parabolic_movement.new()
		p._inic(c)
		var dir = 1
		if c.position.x - c.player.position.x > 0:
			dir = -1
		p._goal = c.position + Vector2(dir*26,0)
		p.self_call = true
		p.tspeed = 0.7
		p.arc_height = 30
		c.deals_damage_on_touch = true
		p.connect("reached_goal", Callable(self, "_return_state"))
	
		c.add_child(p)
		c.find_child("middle_area").connect("body_entered", Callable(self, "test_col").bind(p))
		
		
func test_col(b,p):
	var ground_detector = control.find_child("below_ground_detector")
	if ground_detector.get_collider() == b:
		p._end()
		control.find_child("middle_area").disconnect("body_entered", Callable(self, "test_col"))		
		control._fix_on_ground()

func _return_state():
	control._change_state("attacking")

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
