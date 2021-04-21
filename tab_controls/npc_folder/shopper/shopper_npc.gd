extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var opened = false
var can_close = true
var options = []
var items = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var open_shop_option = dialogue_piece.new()
	open_shop_option.option_name = "buy stuff"
	open_shop_option.call = "open_shop"
	
	

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
	
	options.append(open_shop_option)
	options.append(main_dialogue)
	
	items = []
	var item = load("res://items/item.tscn")
	items.append(item.instance())
	items.append(item.instance())
	items.append(item.instance())
	
	$shop_area.tab_path = "res://tab_controls/npc_folder/shopper/shop.tscn"
	
	$shopper_area.connect("interacted_object", self, "npc_interaction")
	
	pass # Replace with function body.

func npc_interaction():
	
	if not npc_control:
		npc_control =load("res://tab_controls/npc_folder/dialogue/npc_control.tscn").instance()
		get_tree().get_current_scene().add_child(npc_control)
		start_npc_dialogue()
		var inv = get_tree().get_current_scene().get_node("Inventory")
		inv.connect("opened_inventory", self, "cancel_click")
		#get_tree().paused = true
	elif opened and can_close: 
		get_tree().get_current_scene().remove_child(npc_control)
		npc_control = null
		opened = false
		var inv = get_tree().get_current_scene().get_node("Inventory")
		inv.disconnect("opened_inventory", self, "cancel_click")
		#get_tree().paused = false
		
	pass

var dial = preload("res://tab_controls/npc_folder/dialogue/dialogue.tscn")
func dialogue(dialogue_lines):
	var dialogue = dial.instance()
	
	var end_call = ""
	if dialogue_lines.next_opts:
		end_call = "continue_npc_dialogue"
	else:
		end_call = "start_npc_dialogue"
	
	dialogue.make_dialogue(dialogue_lines.lines, self,end_call,
	dialogue_lines.next_opts)
	npc_control.hide()
	get_tree().get_current_scene().add_child(dialogue)
	opened = false

	
	
func cancel_click():
	var inv = get_tree().get_current_scene().get_node("Inventory")
	inv.close_inventory()
	
func open_shop(d):
	var controller = shopper_control.new()

	$shop_area.open_tab(items, controller)
	$shopper_area.connect("interacted_object", $shop_area,
	"close_tab", [],CONNECT_ONESHOT)
	$shopper_area.connect("interacted_object", self,
	"start_npc_dialogue", [],CONNECT_ONESHOT)
	
	$shop_area.connect("tab_closed", self, "update_items", [], CONNECT_ONESHOT)
	opened = false
	
	npc_control.hide()
	
	
func update_items(new_items):
	items = new_items

func continue_npc_dialogue(options):
	npc_control.make_options(options, self)
	opened = true
	npc_control.show()
	can_close = false

func start_npc_dialogue():
	npc_control.make_options(options, self)
	opened = true
	npc_control.show()
	can_close = true
	

var npc_control
func _process(delta):
	pass#start_npc_dialogue(options)

