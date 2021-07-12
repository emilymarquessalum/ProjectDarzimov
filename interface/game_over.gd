extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var cam = get_tree().get_current_scene().find_node("Camera2D")
	
	rect_position = cam.offset + cam.position - Vector2(170,110)
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		get_tree().change_scene("res://rooms/reset_scene.tscn")

func _process(delta):
	if modulate.a8 < 230:
		modulate.a8 +=5 
