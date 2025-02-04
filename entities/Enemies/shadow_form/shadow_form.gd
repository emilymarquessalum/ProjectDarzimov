extends Enemy

var patterns = [
	{'pattern' :[0,60,50,50], 'indication': [0,0,5]},
	{'pattern' :[30,25,10], 'indication': [5,0,0]}]


var p_index = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	unique_to_scene = false
	var jump = load("res://entities/Enemies/jump_behaviour.gd").new()
	find_child("Health").connect('died', Callable(self, "_justica_reset"))
	behaviours.append(jump)
	jump.controller = self
	var p = get_tree().get_current_scene().find_child("Player")
	var dir = -1
	if p.flip:
		dir *= -1
	_look_at(p.position, true)
	var po = Game._get_random_empty_floor()
	if po:
		position = po.position
	var areas = find_child("middle_area")
	
	while (abs(position.x -  player.position.x) > 170 or abs(position.x -  player.position.x) < 20) and (not find_child("GroundDetector").is_colliding() or areas._inside_floors()):
		po = Game._get_random_empty_floor()
		if po:
			position = po.position
		
	scale.x = -scale.x	
	position.y -= 80
	_fix_on_ground()
	var player = get_tree().get_current_scene().find_child("Player")
	self.keywords = player.keywords
	
var dest_y = 0
func _jump(c):
	dest_y = -c.jump_frames * c.jump_power	

func _justica_reset():
	CardsData.justica.behaviour.spawned_shadow = false




@onready var state = find_child("awake")
var time_on_state = 120

func _change_state(a=0,s=""):
	state = find_child(s)
	time_on_state = 0
	

var dest
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#_look_at(player.position, true)
	
	

	dest = Vector2.ZERO
	dest.y = gravity
	dest.x = 0
	time_on_state += 1
	if not dest_y == 0 and state == find_child('running'):
		dest.y = dest_y
	dest_y = 0
	
	state._update(self)

	set_velocity(dest)
	set_up_direction(Vector2.UP)
	move_and_slide()
