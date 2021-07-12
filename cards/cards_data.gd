extends Node
class_name cards_data


var justica = {'sprite' : preload("res://res/Cursor.png"), 
'description': "Super arco.",
'behaviour' : preload("res://cards/card_items/justiça.gd").new()}


var cards_d	= [null,null,null]


# Called when the node enters the scene tree for the first time.
func _ready():
	return
	var save_path = "res://scene_data/" + get_tree().get_current_scene().area_name
	var load_file = File.new()
	
	
	var err = load_file.open(save_path, File.READ)
	if err:
		return
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
