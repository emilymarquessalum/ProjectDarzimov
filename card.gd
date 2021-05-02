extends TextureRect

var card 

func _ready():
	card= load("res://items/card.gd").new()
	card._inic()
	texture = card.card_type.sprite

func _on_mouse_entered():
	var descript = get_tree().get_current_scene().find_node("description_text")
	descript._change_description(card)

func _on_mouse_exited():
	var descript = get_tree().get_current_scene().find_node("description_text")
	descript._change_description(null)
