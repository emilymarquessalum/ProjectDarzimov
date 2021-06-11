extends Node2D
class_name npc
var npc_control
var options = []
var dialogue_pointer = 0
var can_open = true
var dial = preload("res://tab_controls/npc_folder/dialogue/dialogue.tscn")
var dialogue
var dialogue_index = 0
var opened = false

export(String) var save_path = "user://.txt"
var data
func _ready():
	npc_control = load("res://tab_controls/npc_folder/npc_control.tscn").instance()
	add_child(npc_control)
	npc_control.hide()
	_inic_behaviour()
	#dialogue_pointer = saved_conversation.index
	var save_file = File.new()
	$Area2D.connect("interacted_object", self, "_start_dialogue")
	
	var err = save_file.open(save_path, File.READ)
	if err == OK:
		var file_text = save_file.get_as_text()
		data = parse_json(file_text)
		assert(data)
		dialogue_pointer = data['index']
		for piece in data['dialogue']:
			var has_characters = piece.has("first_character") and piece.has("second_character")
			var d_p = dialogue_piece.new()
			if piece.has("first_character"):
				d_p.first_character = piece["first_character"]
			if piece.has("second_character"):
				d_p.second_character = piece["second_character"]
			if has_characters:
				d_p._update_characters()
			if piece.has("lines"):
				
				var proper_piece = piece.has("line_owner") and piece.has("line_sprite")
				if proper_piece:
					for i in range(piece["lines"].size()):
						d_p._add_to_lines([piece["lines"][i]],
						piece["line_owner"][i],
						piece["line_sprite"][i])
				else:
					for i in range(piece["lines"].size()):
						d_p._add_text(piece["lines"][i])
					
			d_p._connect_to_start(piece["start_behaviour"], self)
			if piece.has("end_behaviour"):
				d_p._connect_to_end(piece["end_behaviour"], self)
			if piece.has("skip"):
				d_p.skip = piece.skip
			options.append(d_p)
			
	else:
		print("error")
		
	
	
# definir as opções de dialogo facilmente!
# (you should be overriding this)
func _inic_behaviour():
	pass

func _add_skip(dialogue_l):
	dialogue_pointer += dialogue_l.skip

# Muda o dialógo atual (main branch)
func _change_dialogue_pointer(d = dialogue_pointer + 1):
	dialogue_pointer = d
	
	data.index = dialogue_pointer
	var save_file = File.new()
	
	var err = save_file.open(save_path, File.WRITE)
	
	if err == OK:
		save_file.store_string(to_json(data))
	else:
		print("error")
	
func _close_dialogue():
	opened = false
	dialogue_index = 0
	if npc_control:
		npc_control.hide()
	get_tree().paused = false
	var interface = get_tree().get_current_scene().find_node("interface_control")
	interface.disconnect("opened_interface", self, "_close_interface")
		
func _close_interface():
	var interface = get_tree().get_current_scene().find_node("interface_control")
	interface._close_interface()
	get_tree().paused = true
		
func _close_options(d=null):
	npc_control.hide()
	

func _open_options():
	var next_opts = []
	var pointer = dialogue_pointer
	while dialogue_pointer  < options[pointer].skip + pointer:
		dialogue_pointer += 1
		next_opts.append(options[dialogue_pointer])
	
		
	npc_control._make_options(next_opts, self)
	npc_control.show()
	var player = get_tree().get_current_scene().find_node("Player")
	npc_control.rect_position.x = 0
	npc_control.rect_position.y = -80

func _dialogue(dialogue_lines=options[dialogue_pointer]):
	
	var interface = get_tree().get_current_scene().find_node("interface_control")
	interface.connect("opened_interface", self, "_close_interface")
	dialogue = dial.instance()
	#dialogue_lines.emit_signal("started")
	get_tree().paused = true

	print_debug("!@")
	dialogue._make_dialogue(dialogue_lines)
	

	dialogue.connect("end_dialogue", self, "_ended_dialogue",[dialogue_lines], CONNECT_ONESHOT)
	
	if npc_control:
		npc_control.hide()
	get_tree().get_current_scene().add_child(dialogue)
	
	
func _call_start(piece):
	piece.emit_signal("started")
	
func _ended_dialogue(dialogue):
	dialogue.emit_signal("ended")

func _change_camera():
	var camera = get_tree().get_current_scene().find_node("focus_camera")
	var player= get_tree().get_current_scene().find_node("Player")
	camera.make_current()
	camera.offset.x = player.position.x
	camera.offset.y = player.position.y 
	
	dialogue.rect_scale = Vector2(0.8, 0.6)
	dialogue.rect_position.y += 40
	dialogue.rect_position.x = player.position.x - 36
	
	
func _change_camera_back():
	var camera = get_tree().get_current_scene().find_node("Camera2D")
	camera.make_current()

# funções de diálogo options 
func _start_dialogue(d=null):
	if opened:
		return
		
	print_debug("!@!W")
	options[dialogue_pointer].emit_signal("started", options[dialogue_pointer])
	dialogue_index = 1
	opened = true


func _continue_dialogue(d=null):
	
	options[dialogue_pointer][dialogue_index].emit_signal("started", options[dialogue_pointer][dialogue_index])
	dialogue_index += 1
	#npc_control._make_options(options, self)
	#npc_control.show()
