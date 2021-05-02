extends Control

func _ready():
	pass

onready var player = get_tree().get_current_scene().get_node("Player") 

export var offset_x = 0
export var offset_y = 0
func _process(delta):
	rect_position.x = player.position.x + offset_x
	rect_position.y = player.position.y + offset_y
