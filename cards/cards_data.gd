extends Node
class_name cards_data

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var justica = {'sprite' : preload("res://Cursor.png"), 
'description': "Super arco.",
'behaviour' : preload("res://cards/card_items/justiça.gd").new()}




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
