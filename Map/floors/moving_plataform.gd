extends "res://Map/floors/floor.gd"

@export var speed_x: float = 1
@export var speed_y: float = 1

@export var ignore_x: bool = false
@export var ignore_y: bool = false

func _ready():
	var ps = []
	var n = 1
	var node = find_child("goal" + String(n))
	while node:
		ps.append(node)
		##holders.append(node)
		n += 1
		node = find_child("goal" + String(n))
		
	
	for p in ps:
		position_goals.append(p.global_position)
	
	goal = position_goals[0]
	
	
	line = Line2D.new()
	#line.show_behind_parent = true
	line.width = 6
	ps[0].add_child(line)
	line.add_point(Vector2(0,0))
	line.add_point(ps[1].position-ps[0].position)
	holders.append(line)
var line
var d = false

	
var goal 
var goal_index = 0
var position_goals = []
var holders = []
func _process(delta):
	var m_t = move_toward(global_position.x, goal.x, speed_x)
	var m_t_y = move_toward(global_position.y, goal.y, speed_y)
	for ent in _entities_over():
		ent.global_position.x += m_t - global_position.x 
		ent.global_position.y += m_t_y - global_position.y 
	
	for hold in holders:
		hold.global_position.x+=global_position.x - m_t
		hold.global_position.y+= global_position.y - m_t_y
	
	global_position.x = m_t
	global_position.y = m_t_y
	

	if (ignore_x or abs(global_position.x - goal.x) < 5 or abs(global_position.x + 30 - goal.x) < 5) and (abs(global_position.y - goal.y) < 5 or ignore_y or abs(global_position.y  - goal.y) < 5):
		goal_index += 1
		if goal_index >= position_goals.size():
			goal_index = 0
		goal = position_goals[goal_index]
		
	
	pass
