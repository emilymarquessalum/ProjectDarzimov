extends Control

func _ready():
	pass

onready var player = get_tree().get_current_scene().get_node("Player") 

func _process(delta):
	rect_position.x = player.position.x
	rect_position.y = player.position.y - 30
