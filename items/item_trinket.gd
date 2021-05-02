extends Area2D

func _ready():
	pass # Replace with function body.

var item
func _inic(it):
	$Sprite.texture = it.data.Sprite
	item = it
	inicial_pos_x = position.x
	inicial_pos_y = position.y
	
	_goal = Vector2(position.x + rand_range(-10,10), position.y)
	
var stop = false
var inicial_pos_x
var inicial_pos_y
var _goal
var tspeed = 0.5
var arc_height = 20
var moving = true
var animate = false
var anim_frames =0
signal collided(proj, collision)
signal finished_animation(trinket)
func _process(delta):
	var cols = get_overlapping_bodies()
	
	for col in cols:
		emit_signal("collided", self, col)
	if moving:
		_move(delta)
	else:
		if animate:
			position.y -= 1
			anim_frames += 1
			if anim_frames > 30:
				emit_signal("finished_animation", self)
		pass # probably do some animation here?
	
func _move(delta):

	if stop:
		position.y += 1
	var x0 = inicial_pos_x
	var x1 = _goal.x
	
	var dist = abs(x1 - x0)
	
	if dist == 0:
		get_parent().remove_child(self)

	var nextX = 0
	var dir = 1
	if x0 > x1:
		dir = -1
		
	if dist > tspeed:
		nextX = position.x + (dist / abs(dist) * tspeed * dir)
	else:
		nextX = x1
		stop = true
		return
	var baseY = inicial_pos_y + (_goal.y - inicial_pos_y) * (nextX - x0) / dist * dir
	var arc = arc_height * (nextX - x0) * (nextX - x1) / (-0.5 * dist * dist)
	position = position.move_toward(Vector2(nextX, baseY - arc),delta*100)
