extends Node2D
class_name npc
var npc_control
var dialogue_lines = []
var dialogue_pointer = 0
var can_open = true
var dial = preload("res://tab_controls/npc_folder/dialogue/dialogue.tscn")
var dialogue
var dialogue_index = 0
var last_dialogue_name = null
var opened = false

@export var save_path: String = "user://.txt"
@export var used_dialogues = [] # (Array, String)
var data
func _ready():
	npc_control = load("res://tab_controls/npc_folder/npc_control.tscn").instantiate()
	add_child(npc_control)
	npc_control.hide()
	
	$Area2D.connect("interacted_object", Callable(self, "_start_dialogue"))
	
	var save_file = File.new()
	var err = save_file.open(save_path, File.WRITE)
	if not err == OK:
		return
	
	var test_json_conv = JSON.new()
	test_json_conv.parse(save_file.get_as_text())
	data = test_json_conv.get_data()
	
	
	
	
func _add_skip(dialogue_l):
	dialogue_pointer += dialogue_l.skip

# Muda o dialógo atual (main branch)
func _change_dialogue_pointer(d = dialogue_pointer + 1):
	dialogue_pointer = d
	
	data.index = dialogue_pointer
	var save_file = File.new()
	
	var err = save_file.open(save_path, File.WRITE)
	
	if err == OK:
		save_file.store_string(JSON.new().stringify(data))
	else:
		print("error")
	
func _close_dialogue():
	opened = false
	dialogue_index = 0
	if npc_control:
		npc_control.hide()
	get_tree().paused = false
	var interface = get_tree().get_current_scene().find_child("interface_control")
	interface.disconnect("opened_interface", Callable(self, "_close_interface"))
		
func _close_interface():
	var interface = get_tree().get_current_scene().find_child("interface_control")
	interface._close_interface()
	get_tree().paused = true
		
func _close_options(d=null):
	npc_control.hide()
	

func _open_options():
	var next_opts = []
	var pointer = dialogue_pointer
	while dialogue_pointer  < dialogue_lines[pointer].skip + pointer:
		dialogue_pointer += 1
		next_opts.append(dialogue[dialogue_pointer])
	
		
	npc_control._make_options(next_opts, self)
	npc_control.show()
	var player = get_tree().get_current_scene().find_child("Player")
	npc_control.position.x = 0
	npc_control.position.y = -80

func _dialogue(dialogue_lines=dialogue_lines[dialogue_pointer]):
	
	var interface = get_tree().get_current_scene().find_child("interface_control")
	interface.connect("opened_interface", Callable(self, "_close_interface"))
	dialogue = dial.instantiate()
	#dialogue_lines.emit_signal("started")
	get_tree().paused = true

	dialogue._make_dialogue(dialogue_lines)
	

	dialogue.connect("end_dialogue", Callable(self, "_ended_dialogue").bind(dialogue_lines), CONNECT_ONE_SHOT)
	
	if npc_control:
		npc_control.hide()
	get_tree().get_current_scene().add_child(dialogue)
	
	
func _call_start(piece):
	piece.emit_signal("started")
	
func _ended_dialogue(dialogue):
	dialogue.emit_signal("ended")

func _change_camera():
	var camera = get_tree().get_current_scene().find_child("focus_camera")
	var player= get_tree().get_current_scene().find_child("Player")
	camera.make_current()
	camera.offset.x = player.position.x
	camera.offset.y = player.position.y 
	
	dialogue.scale = Vector2(0.8, 0.6)
	dialogue.position.y += 40
	dialogue.position.x = player.position.x - 36
	
	
func _change_camera_back():
	var camera = get_tree().get_current_scene().find_child("Camera2D")
	camera.make_current()

# funções de diálogo options 
func _start_dialogue(d=null):
	if opened:
		return
	var scene_name = get_tree().get_current_scene().area_name
	var dialogue_name = null
	if data["dialogue_name_index"].has(scene_name):
		dialogue_name = data["dialogue_name_index"][scene_name]
		
	
	var dialogue_line = _get_dialogue_line(dialogue_name)
	if dialogue_line == null:
		return
	dialogue_line.emit_signal("started", dialogue_line)
	dialogue_index = 1
	opened = true

func _get_dialogue_line(current_dialogue_name = null):
	var current_dialogue_data
	
	if current_dialogue_name == null:
		if used_dialogues.size() >= dialogue_index:
			return null
		current_dialogue_name = used_dialogues[dialogue_index]

	dialogue_index += 1
	current_dialogue_data = data["dialogues"][current_dialogue_name]
			
	if current_dialogue_data.has("completed"):
		return _get_dialogue_line()
		
	var current_dialogue = dialogue_piece.new()
	current_dialogue._start(current_dialogue_data, self)
	last_dialogue_name = current_dialogue_name
	return current_dialogue
	
func _continue_dialogue(d=null):
	_save_as_completed_and_continue(last_dialogue_name)
	var dialogue_line = _get_dialogue_line()
	if dialogue_line == null:
		return
	dialogue_line.emit_signal("started", dialogue_line)
	
	#npc_control._make_options(options, self)
	#npc_control.show()
func _save_as_completed_and_continue(dial_name):
	var save_file = File.new()
	
	var err = save_file.open(save_path, File.READ_WRITE)
	
	if err == OK:
		var test_json_conv = JSON.new()
		test_json_conv.parse(save_file.get_as_text())
		data = test_json_conv.get_data()
		data["dialogues"][dial_name]["completed"] = true
		var scene_name = get_tree().get_current_scene().area_name
	
		if used_dialogues.size() < dialogue_index + 1:
			data["dialogue_name_index"][scene_name] = used_dialogues[dialogue_index + 1]
		else:
			data["dialogue_name_index"][scene_name] = null
		save_file.store_string(JSON.new().stringify(data))
	else:
		print("error")
