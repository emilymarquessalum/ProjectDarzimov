extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(int) var acceptable_distance = 10
func _start_behaviour():
	pass
	
	
func _update(delta, control):
	
	if abs(control.player.position.x - control.position.x) > acceptable_distance:
		control.velocity.x = 0
		return
	
	
	if (control.player.position.x - control.position.x) > 0:
		control.velocity.x =  (control.speed * 1.5)*-1 
	else:
		 control.velocity.x =  -(control.speed * 1.5) *-1

