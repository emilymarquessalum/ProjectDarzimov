extends "res://entities/behaviour.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _start_behaviour():
	pass
	
	
func _update(delta, en):
	var ground_detect =en.find_node("enemy_properties").get_node("front_ground_detector")
	if not ground_detect.is_colliding() and en.is_on_floor() :
		en.flip = !en.flip
		en.scale.x = -en.scale.x
	
	en.velocity.x = (-en.speed if en.flip else en.speed)
	
	
