extends Node
class_name dialogue_piece
# Como a opção vai ser mostrada nas opções:
var option_name = "undefined"
# Próximas linhas de diálogo (caso ela leve a mais diálogo)
var lines = []

var first_character 
var second_character 
var last_exp_1 = "neutral"
var last_exp_2 = "neutral"

func _update_characters():
	first_character = _get_character(first_character)
	second_character = _get_character(second_character)

func _get_character(name):
	var f = "res://dialogue/characters/"
	return load(f + name + ".tres")

func _add_text(line_text):
	var dict_dialogue = {}
	dict_dialogue["text"] = line_text 
	lines.append(dict_dialogue)
	
func _start(data,controller):
	first_character = data["characters"][0]
	second_character = data["characters"][1]
	_update_characters()

	for line in data["lines"]:
		_add_to_lines(line["text"], line["first_character"], line["second_character"], line["state_1"],line["state_2"], line["speaker"])

	_connect_to_start(data["start"], controller)
	_connect_to_end(data["end"], controller)

func _add_to_lines(line_text,f_char, s_char, exp_1, exp_2, speaker):
	var dict_dial = {}
	dict_dial["text"] = line_text 		
	
	f_char = _get_character(f_char) if f_char else first_character
	s_char = _get_character(s_char) if s_char else second_character
	
	exp_1 = last_exp_1 if not exp_1 else exp_1
	exp_2 = last_exp_2 if not exp_2 else exp_2
	
	last_exp_1 =  exp_1
	last_exp_2 = exp_2
	
	dict_dial["char_direction"] = 0 if speaker == f_char else 1
	dict_dial["first_character_sprite"] = f_char.sprites[exp_1]
	dict_dial["second_character_sprite"] = s_char.sprites[exp_2]

	lines.append(dict_dial)
	
# Mais opções depois dela!
var next_opts = null

# Funções que vão ser chamadas depois que ela for escolhida!
signal started()
signal ended()

func _connect_to_start(connections, controller):
	for connection in connections:
		connect("started", Callable(controller, connection))

func _connect_to_end(connections, controller):
	for connection in connections:
		connect("ended", Callable(controller, connection))

func _start_basic_dialogue(npc):
	_connect_to_start(["_dialogue","_change_camera"],npc)
	

func _end_basic_dialogue(npc):
	_connect_to_end(["_close_dialogue", "_change_camera_back"]
		,npc)
