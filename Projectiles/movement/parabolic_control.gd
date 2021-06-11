extends Node
class_name parabolic_movement

var _goal
var inicial_pos_x
var inicial_pos_y
var tspeed = 0.5
var arc_height = 20
var control
var stop = false
func _inic(object):
	control = object
	inicial_pos_x = object.position.x
	inicial_pos_y = object.position.y
	
	
var self_call = false
var goal_reach = 0
var x_strict = false
func _physics_process(delta):
	if self_call:
		_update(delta)
	
	
func _end():
	get_parent().remove_child(self)
	emit_signal("reached_goal")	

signal reached_goal()
func _update(delta):
	if stop:
		if x_strict:
			_end()
		control.position.y += 1
		return
	var x0 = inicial_pos_x
	var x1 = _goal.x
	
	var dist = abs(x1 - x0)
	
	if dist <= goal_reach:
		_end()
	var nextX = 0
	var dir = 1
	if x0 > x1:
		dir = -1
		
	if dist > tspeed:
		nextX = control.position.x + (dist / abs(dist) * tspeed * dir)
	else:
		nextX = x1
		stop = true
		return
	var baseY = inicial_pos_y + (_goal.y - inicial_pos_y) * (nextX - x0) / dist * dir
	var arc = arc_height * (nextX - x0) * (nextX - x1) / (-0.5 * dist * dist)
	control.position = control.position.move_toward(Vector2(nextX, baseY - arc),delta*100)
