extends Node

var card_options = ["res://cards/lion.tres","res://cards/medusa.tres"]
var card_type

func _inic():
	card_type = load(card_options[rand_range(0, card_options.size())])
	pass 

func _get_description():
	return card_type.description
