extends "res://Map/floors/floor.gd"

export(float) var speed_x = 1
export(float) var speed_y = 1


func _ready():
	var ps = []
	var n = 1
	var node = find_node("goal" + String(n))
	while node:
		ps.append(node)
		n += 1
		node = find_node("goal" + String(n))
	
	for p in ps:
		position_goals.append(p.global_position)
	
	goal = position_goals[0]
var d = false

	
var goal 
var goal_index = 0
var position_goals = []
func _process(delta):
	var m_t = move_toward(global_position.x, goal.x, speed_x)
	var m_t_y = move_toward(global_position.y, goal.y, speed_y)
	for ent in _entities_over():
		ent.global_position.x -= global_position.x - m_t
		ent.global_position.y -= global_position.y - m_t_y
	
	position.x = m_t
	position.y = m_t_y
	#position.y = move_toward(position.y, goal.position.y, 1)
	
	if (abs(position.x - goal.x) < 5 or abs(position.x + 48 - goal.x) < 5) and (abs(position.y - goal.y) < 5 ):
		goal_index += 1
		if goal_index >= position_goals.size():
			goal_index = 0
		goal = position_goals[goal_index]
		
	
	pass