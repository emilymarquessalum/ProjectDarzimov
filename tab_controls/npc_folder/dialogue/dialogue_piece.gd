extends Node
class_name dialogue_piece
# Como a opção vai ser mostrada nas opções:
var option_name = "undefined"
# Próximas linhas de diálogo (caso ela leve a mais diálogo)
var lines = []

var first_character = {'sprite' : null}
var second_character = {'sprite' : null}
var skip
func _update_characters():
	var f = "res://dialogue/characters/"
	
	first_character = load(f + first_character + ".tres")
	second_character = load(f + second_character + ".tres")
	
	pass # use paths to find them


func _add_text(line_text):
	var dict_dialogue = {}
	dict_dialogue["text"] = line_text 
	lines.append(dict_dialogue)
	


func _add_to_lines(line_text,character, expression):
	var dict_dialogue = {}
	dict_dialogue["text"] = line_text 
	
	dict_dialogue["first_character_sprite"] = first_character.sprites["neutral"]
			
	dict_dialogue["first_character"] = first_character
	dict_dialogue["second_character"] = second_character
	dict_dialogue["second_character_sprite"] = second_character.sprites["neutral"]
	
	dict_dialogue["character"] = first_character if character == 0  else second_character 

	if character == 0:
		dict_dialogue["first_character_sprite"] = first_character.sprites[expression]

	if character == 1:
		dict_dialogue["second_character_sprite"] = second_character.sprites[expression]

		
		
	lines.append(dict_dialogue)
	
# Mais opções depois dela!
var next_opts = null

# Funções que vão ser chamadas depois que ela for escolhida!
signal started()
signal ended()

func _connect_to_start(connections, controller):
	for connection in connections:
		connect("started", controller, connection)

func _connect_to_end(connections, controller):
	for connection in connections:
		connect("ended", controller, connection)

func _start_basic_dialogue(npc):
	_connect_to_start(["_dialogue","_change_camera"],npc)
	

func _end_basic_dialogue(npc):
	_connect_to_end(["_close_dialogue", "_change_camera_back"]
		,npc)
