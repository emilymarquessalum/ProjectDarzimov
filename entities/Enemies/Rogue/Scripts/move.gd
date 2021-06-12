extends behaviour


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
	var will_fall = not ground_detect.is_colliding() and en.is_on_floor() 
	
	
	var in_front = en.get_node("direction_collision")
	 
	if will_fall or in_front.is_colliding():
		en.flip = not en.flip
		en.scale.x = -en.scale.x
	en.velocity.x = en.speed * en._get_direction()
	
	



