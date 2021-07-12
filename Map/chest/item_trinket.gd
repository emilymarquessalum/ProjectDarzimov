extends Area2D

var item 
var movement
var moving = true
var animate = false 

var anim_frames = 0
# used to change the y position when the player collides 
#with the trinket

var touch_delay = 0
var touch_frames = 0

signal collided(proj, collision)
signal finished_animation(trinket)

func _inic(it):
	$Sprite.texture = it.data.sprite
	item = it
	movement = parabolic_movement.new()
	movement._inic(self)
	movement._goal = Vector2(position.x + rand_range(-10,10), position.y)
	connect("collided", self, "_collision")



func _process(delta):
	var cols = get_overlapping_bodies()
	
	for col in cols:
		emit_signal("collided", self, col)
	if moving:
		_move(delta)
	else:
		touch_frames += 1
		if animate:
			position.y -= 1
			anim_frames += 1
			if anim_frames > 30:
				emit_signal("finished_animation", self)
		pass 
	
func _move(delta):
	movement._update(delta)


func _collision(trinket, obj):
	if obj is TileMap and trinket.moving:
		trinket.moving = false
		trinket.position.y -= 5
		
		#var movement = parabolic_movement.new()
		#movement._goal = trinket.movement._goal * Vector2(-1,1)
		#movement._inic(trinket)
		#trinket.movement = movement
		return
	
	if touch_frames < touch_delay:
		return
	var inv = get_tree().get_current_scene().find_node("Inventory")
	if obj.is_in_group("Player") and not trinket.moving and not trinket.animate:
		if inv._add_to_inventory(trinket.item):
			trinket.animate = true
			trinket.connect("finished_animation", self, "_trinket_finished_animation")
		
func _trinket_finished_animation(trinket):
	trinket.get_parent().remove_child(trinket)
