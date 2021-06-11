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
		p.x_strict = true
		p._goal = c.position - Vector2(20,0)
		p.self_call = true
		c.deals_damage_on_touch = true
		p.connect("reached_goal", self, "_return_state")
		c.add_child(p)
		c.find_node("middle_area").connect("body_entered", self, "test_col",[p])
		
		
func test_col(b,p):
	
	if b.is_in_group("Ground"):
		print_debug("aaa")
		#p._end()
		control.get_node("chest").disconnect("area_entered", self, "test_col")		
		
func _return_state():
	control._change_state("attacking")
	control.get_node("chest").disconnect("area_entered", self, "test_col")		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
