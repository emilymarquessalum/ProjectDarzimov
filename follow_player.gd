extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

onready var player = get_tree().get_current_scene().get_node("Player") 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rect_position.x = player.position.x
	rect_position.y = player.position.y - 30