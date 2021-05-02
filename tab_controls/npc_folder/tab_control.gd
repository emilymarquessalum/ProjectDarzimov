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
	pass # Replace with function body.


func _remove_tab():
	if tab:
		get_parent().remove_child(tab)
		tab = null
		

func _inicialize_tab(itens	: Array = items, controller = control):
	_remove_tab()
	tab =  load(tab_path).instance()
	get_parent().add_child(tab)
	
	tab.hide()
	
	items = itens
	control = controller
	
	pass

func _add_to_tab_items(slot):
	var item = slot._take_item_from_slot()
	_add_item_to_tab_items(item)
	
func _add_item_to_tab_items(item):
	for slot in tab.slots:
		if slot.item == null:
			slot._put_item_into_slot(item)
			return
	
	
var tab
signal tab_opened()
# opens tab, has a default value of itself
func _open_tab(itens	: Array = items, controller = control):
	emit_signal("tab_opened")

	opened = true
	_inicialize_tab()
	tab.show()
	var inv = get_tree().get_current_scene().find_node("Inventory")
	inv._interface_opened()
	tab.open_tab(self,itens,  controller)


signal tab_closed(items)
func _close_tab():
	opened = false
	items = tab.get_items()
	_remove_tab()
	emit_signal("tab_closed", items)
	var inv = get_tree().get_current_scene().find_node("Inventory")
	inv._interface_closed()
	

	
	
func _change_tab_state():
	if opened:
		_close_tab()
	else:
		_open_tab()


