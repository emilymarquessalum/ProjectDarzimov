extends Node
class_name dialogue_piece
# Como a opção vai ser mostrada nas opções:
var option_name = "undefined"
# Próximas linhas de diálogo (caso ela leve a mais diálogo)
var lines = []

var first_character = {'sprite' : null}
var second_character = {'sprite' : null}


func _add_to_lines(line_text,character, override=null):
	var dict_dialogue = {}
	dict_dialogue["text"] = line_text 
	
	dict_dialogue["first_character_sprite"] = first_character.sprite
			
	dict_dialogue["first_character"] = first_character
	dict_dialogue["second_character"] = second_character
	dict_dialogue["second_character_sprite"] = second_character.sprite
	
	dict_dialogue["character"] = character

	
	
	if override:
		if character == first_character:
			dict_dialogue["first_character_sprite"] = override

		if character == second_character:
			dict_dialogue["second_character_sprite"] = override

		
		
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
