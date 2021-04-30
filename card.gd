extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	card= load("res://items/card.gd").new()
	card.inic()
	texture = card.card_type.sprite
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var card 

func _on_mouse_entered():
	
	var descript = get_tree().get_current_scene().find_node("description_text")
	descript.change_description(card)

func _on_mouse_exited():
	
	var descript = get_tree().get_current_scene().find_node("description_text")
	descript.change_description(null)
