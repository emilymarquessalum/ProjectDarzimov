extends Camera2D

onready var player = get_tree().get_current_scene().get_node("Player") 
func _ready():
	pass 

func _process(delta):
	position.x = player.position.x
	position.y = player.position.y - 60
