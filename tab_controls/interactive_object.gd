extends Area2D

class_name interactive_object


func _ready():
	pass # Replace with function body.

signal interacted_object()
func _interacting():
	if Input.is_action_just_pressed("interact"):
		var player = get_tree().get_current_scene().get_node("Player")
		if overlaps_body(player):
			emit_signal("interacted_object")
			return true
	return false


var interactive = true
func _process(delta):
	_interacting()
