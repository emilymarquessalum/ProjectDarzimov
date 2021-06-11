extends Camera2D
onready var player = get_tree().get_current_scene().find_node("Player")
var on = true
onready var scene = get_tree().get_current_scene()
func _process(delta):
	if not on:
		return
	position.x = player.position.x
	if position.x <= scene.room_x:
		position.x = scene.room_x
		
	if position.x >= scene.room_width:
		position.x = scene.room_width

	position.y = player.position.y 
	
	if position.y > scene.room_height:
		position.y = scene.room_height
