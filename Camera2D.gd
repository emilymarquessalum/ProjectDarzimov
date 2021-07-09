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
	if position.x <= scene.room_x:
		position.x = scene.room_x
		
	if position.x >= scene.room_width:
		position.x = scene.room_width
	
	if position.y > scene.room_height:
		position.y = scene.room_height
	if position.y < scene.room_y:
		position.y = scene.room_y
