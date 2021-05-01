extends Node2D

class_name tab_control

var opened = false
var items = []
var control 
var tab_path 
var itemClass = load("res://items/item.tscn")

func _ready():
	#items.append(itemClass.instance())
	#items.append(itemClass.instance())
	pass 

func remove_tab():
	if tab:
		get_parent().remove_child(tab)
		tab = null
		

func inicialize_tab(itens	: Array = items, controller = control):
	remove_tab()
	tab =  load(tab_path).instance()
	get_parent().add_child(tab)
	
	tab.hide()
	
	items = itens
	control = controller
	
	pass

func add_to_tab_items(slot):
	var item = slot.take_item_from_slot()
	add_item_to_tab_items(item)
	
func add_item_to_tab_items(item):
	for slot in tab.slots:
		if slot.item == null:
			slot.put_item_into_slot(item)
			return

var tab
signal tab_opened()

func open_tab(itens	: Array = items, controller = control):
	emit_signal("tab_opened")

	opened = true
	inicialize_tab()
	tab.show()
	var inv = get_tree().get_current_scene().find_node("Inventory")
	inv.interface_opened()
	tab.open_tab(self,itens,  controller)

signal tab_closed(items)
func close_tab():
	opened = false
	items = tab.get_items()
	remove_tab()
	emit_signal("tab_closed", items)
	var inv = get_tree().get_current_scene().find_node("Inventory")
	inv.interface_closed()

func change_tab_state():
	if opened:
		close_tab()
	else:
		open_tab()
