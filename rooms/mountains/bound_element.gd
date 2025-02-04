@tool
extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	old_pos = position
	pass # Replace with function body.


var old_pos = position
func _process(delta):
	if not Engine.is_editor_hint():
		return
	if old_pos.x != position.x or old_pos.y != position.y:
		get_parent().update()
	
	old_pos = position
	pass
