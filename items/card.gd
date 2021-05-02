extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var card_options = ["res://cards/lion.tres","res://cards/medusa.tres"]
var card_type
# Called when the node enters the scene tree for the first time.
func _inic():
	card_type = load(card_options[rand_range(0, card_options.size())])
	pass # Replace with function body.

func _get_description():
	return card_type.description
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
