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


func remove_tab():
	if tab:
		get_tree().get_current_scene().remove_child(tab)
		tab = null
		

func inicialize_tab(itens	: Array = items, controller = control):
	remove_tab()
	tab =  load(tab_path).instance()
	get_tree().get_current_scene().add_child(tab)
	tab.hide()
	
	items = itens
	control = controller
	
	pass


var tab
signal tab_opened()
# opens tab, has a default value of itself
func open_tab(itens	: Array = items, controller = control):
	emit_signal("tab_opened")

	opened = true
	inicialize_tab()
	tab.show()
	# replace: 
	tab.open_tab(itens,  controller)


signal tab_closed(items)
func close_tab():
	opened = false
	items = tab.get_items()
	remove_tab()
	emit_signal("tab_closed", items)
	
	

	
	
func change_tab_state():
	if opened:
		close_tab()
	else:
		open_tab()

