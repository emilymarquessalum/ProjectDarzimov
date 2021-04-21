extends Area2D

class_name interactive_object
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

signal interacted_object()
func interacting():
	if Input.is_action_just_pressed("interact"):
		var player = get_tree().get_current_scene().get_node("Player")
		if overlaps_body(player):
			emit_signal("interacted_object")
			return true
			
	return false


var interactive = true
func _process(delta):
	interacting()
