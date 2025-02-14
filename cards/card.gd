extends TextureRect

var card 

func _ready():
	texture = load("res://random_images/icon.png")

func _change_card(new_card):
	
	card = new_card
	if card:
		texture = card.sprite
	
		
		
func _on_mouse_entered():
	var descript = get_tree().get_current_scene().find_child("description_text")
	descript._change_description(self)
	

func _on_mouse_exited():
	var descript = get_tree().get_current_scene().find_child("description_text")
	descript._change_description(null)

func _get_description():
	if not card:
		return ""
	return card.description
