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

func _ready():
	npc_control = load("res://tab_controls/npc_folder/npc_control.tscn").instance()
	add_child(npc_control)
	npc_control.hide()
	_inic_behaviour()

# definir as opções de dialogo facilmente!
# (you should be overriding this)
func _inic_behaviour():
	pass

# Muda o dialógo atual (main branch)
func _change_dialogue_pointer(d = dialogue_pointer + 1):
	dialogue_pointer = d

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
	npc_control._make_options(options[dialogue_pointer][dialogue_index - 1].next_opts, self)
	npc_control.show()
	var player = get_tree().get_current_scene().find_node("Player")
	npc_control.rect_position.x = 0
	npc_control.rect_position.y = -80

func _dialogue(dialogue_lines):
	
	var interface = get_tree().get_current_scene().find_node("interface_control")
	interface.connect("opened_interface", self, "_close_interface")
	dialogue = dial.instance()
	dialogue_lines.emit_signal("started")
	get_tree().paused = true


	dialogue._make_dialogue(dialogue_lines.lines)
	

	dialogue.connect("end_dialogue", self, "_ended_dialogue",[dialogue_lines], CONNECT_ONESHOT)
	
	if npc_control:
		npc_control.hide()
	get_tree().get_current_scene().add_child(dialogue)
	
	
func _call_start(piece):
	piece.emit_signal("started")
	
func _ended_dialogue(dialogue):
	print_debug("!")
	dialogue.emit_signal("ended")

func _change_camera():
	var camera = get_tree().get_current_scene().find_node("focus_camera")
	var player= get_tree().get_current_scene().find_node("Player")
	camera.make_current()
	camera.offset.x = player.position.x
	camera.offset.y = player.position.y -130
	
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
	options[dialogue_pointer][0].emit_signal("started", options[dialogue_pointer][0])
	dialogue_index = 1
	opened = true


func _continue_dialogue(d=null):
	
	options[dialogue_pointer][dialogue_index].emit_signal("started", options[dialogue_pointer][dialogue_index])
	dialogue_index += 1
	#npc_control._make_options(options, self)
	#npc_control.show()

