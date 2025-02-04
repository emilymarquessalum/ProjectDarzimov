extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var animation_up = true
func _update(p):
	
	p._look_at(p.player.position, true)
	if animation_up:
		p.find_child("Sprite2D").modulate.r8 += p.patterns[p.p_index].indication[0]
		p.find_child("Sprite2D").modulate.g8 += p.patterns[p.p_index].indication[1]
		p.find_child("Sprite2D").modulate.b8 += p.patterns[p.p_index].indication[2]
		if p.find_child("Sprite2D").modulate.r8 == 255 or p.find_child("Sprite2D").modulate.g8 == 255 or p.find_child("Sprite2D").modulate.b8 == 255:
			animation_up = false
	else:
		p.find_child("Sprite2D").modulate.r8 -= p.patterns[p.p_index].indication[0]
		p.find_child("Sprite2D").modulate.g8 -= p.patterns[p.p_index].indication[1]
		p.find_child("Sprite2D").modulate.b8 -= p.patterns[p.p_index].indication[2]
		if p.find_child("Sprite2D").modulate.r8 == 0 and p.find_child("Sprite2D").modulate.g8 == 0 and p.find_child("Sprite2D").modulate.b8 == 0:
			animation_up = true
			p._change_state(0,"attacking")
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
