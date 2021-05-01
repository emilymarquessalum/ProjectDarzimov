extends Node2D

var npc_control
var options = []
var can_close = true
var dial = preload("res://tab_controls/npc_folder/dialogue/dialogue.tscn")

func _ready():
	$Area2D.connect("interacted_object", self, "open")
	

	var main_dialogue = dialogue_piece.new()
	main_dialogue.option_name = "talk to"
	main_dialogue.lines = ["hey there!", "do you agree?"]	
	
	var answer_yes = dialogue_piece.new()
	answer_yes.option_name = "yes"
	answer_yes.lines = ["I am glad we agree"]
	
	var answer_no = dialogue_piece.new()
	answer_no.option_name = "no"
	answer_no.lines = ["....leave!"]
	
	main_dialogue.next_opts = [answer_yes, answer_no]

	options.append(main_dialogue)
	
func open():
	if not npc_control:
		npc_control = load("res://tab_controls/npc_folder/dialogue/npc_control.tscn").instance()
		get_tree().get_current_scene().add_child(npc_control)
		start_npc_dialogue()
		get_tree().paused = true
		var interface = get_tree().get_current_scene().find_node("interface_control")
		interface.connect("opened_interface", self, "close_interface")
	elif can_close:
		get_tree().get_current_scene().remove_child(npc_control)
		npc_control = null
		get_tree().paused = false
		var interface = get_tree().get_current_scene().find_node("interface_control")
		interface.disconnect("opened_interface", self, "close_interface")
		
func close_interface():
	var interface = get_tree().get_current_scene().find_node("interface_control")
	interface.close_interface()
	get_tree().paused = true
		
func dialogue(dialogue_lines):
	var dialogue = dial.instance()
	can_close = false
	var end_call = ""
	if dialogue_lines.next_opts:
		end_call = "continue_npc_dialogue"
	else:
		end_call = "start_npc_dialogue"
	dialogue.make_dialogue(dialogue_lines.lines, self,end_call,
	dialogue_lines.next_opts)
	npc_control.hide()
	get_tree().get_current_scene().add_child(dialogue)
	
func start_npc_dialogue():
	npc_control.make_options(options, self)
	npc_control.show()
	can_close = true

func continue_npc_dialogue(options):
	npc_control.make_options(options, self)
	npc_control.show()

