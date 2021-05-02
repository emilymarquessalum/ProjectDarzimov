extends Camera2D

onready var player = get_tree().get_current_scene().get_node("Player") 

func _process(delta):
	position.x = player.position.x
	if position.x <= 150:
		position.x = 150
