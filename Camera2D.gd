extends Camera2D
onready var player = get_tree().get_current_scene().find_node("Player")
var on = true
onready var scene = get_tree().get_current_scene()
export(bool) var setting = true
func _process(delta):
	if not on:
		return
	position.x = player.position.x


	position.y = player.position.y 
	if not setting:
		return
	if global_position.x*zoom.x <= scene.room_x:
		global_position.x = scene.room_x *zoom.x
		
	if global_position.x *zoom.x>= scene.room_width:
		global_position.x = scene.room_width*zoom.x
	
	if global_position.y*zoom.y > scene.room_height:
		global_position.y = scene.room_height*zoom.y
	if global_position.y*zoom.y < scene.room_y:
		global_position.y = scene.room_y*zoom.y
