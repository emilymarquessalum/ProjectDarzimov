extends Node
class_name dialogue_maker
var first_character
var second_character

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _make_dialogue_piece():
	var new_dialogue_piece = dialogue_piece.new()
	
	new_dialogue_piece.first_character = first_character
	new_dialogue_piece.second_character = second_character
	return new_dialogue_piece

func _define_characters(f_c, s_c):
	first_character = f_c
	second_character = s_c
