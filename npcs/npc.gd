extends Node2D

var npc_control
var options = []
var can_close = true
var dial = preload("res://tab_controls/npc_folder/dialogue/dialogue.tscn")

func _ready():
	_inic_behaviour()

#  dando override nisso, uma classe pode definir as opções de dialogo
# facilmente!
func _inic_behaviour():
	$Area2D.connect("interacted_object", self, "_open_conversation")
	
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

# Chamado quando o jogador interage com o npc, abrindo ou 
# fechando a tab quando possível
func _open_conversation():
	if not npc_control:
		npc_control = load("res://tab_controls/npc_folder/npc_control.tscn").instance()
		get_tree().get_current_scene().add_child(npc_control)
		_start_dialogue_options()
		get_tree().paused = true
		var interface = get_tree().get_current_scene().find_node("interface_control")
		interface.connect("opened_interface", self, "_close_interface")
	elif can_close:
		get_tree().get_current_scene().remove_child(npc_control)
		npc_control = null
		get_tree().paused = false
		var interface = get_tree().get_current_scene().find_node("interface_control")
		interface.disconnect("opened_interface", self, "_close_interface")
		
func _close_interface():
	var interface = get_tree().get_current_scene().find_node("interface_control")
	interface._close_interface()
	get_tree().paused = true
		
# Inicia novo diálogo (chamado por opções para abrir conversas de 
# dialogo
func _dialogue(dialogue_lines):
	var dialogue = dial.instance()
	can_close = false
	var end_call = ""
	if dialogue_lines.next_opts:
		end_call = "_continue_dialogue_options"
	else:
		end_call = "_start_dialogue_options"

	dialogue._make_dialogue(dialogue_lines.lines, self,end_call,
			dialogue_lines.next_opts)
	npc_control.hide()
	get_tree().get_current_scene().add_child(dialogue)
	
	

# funções de diálogo options (chamar _start pode resetar 
# as opções de diálogo a
# qualquer momento, _continue vai ser chamado para caminhar
# pelas "branches" de diálogo):	
func _start_dialogue_options():
	npc_control._make_options(options, self)
	npc_control.show()
	can_close = true

func _continue_dialogue_options(options):
	npc_control._make_options(options, self)
	npc_control.show()

