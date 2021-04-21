extends Node2D

class_name chest
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var item = load("res://items/item.tscn")
var chest_control = tab_control.new()
onready var interact = $chest
var items = []

func _ready():
	items.append(item.instance())
	items.append(item.instance())
	items.append(item.instance())
	
	
	
	add_child(chest_control)
	chest_control.tab_path = "res://tab_controls/chest_folder/chest_interface.tscn"
	var inv = get_tree().get_current_scene().get_node("Inventory")
	chest_control.connect("tab_opened", inv, "open_inventory")
	
	interact.connect("interacted_object", chest_control, 
	"change_tab_state")
	
	chest_control.connect("tab_closed", self, "update_items")
	
	chest_control.inicialize_tab(items, null)
	pass # Replace with function body.



func update_items(new_items):
	pass
	items = new_items
	chest_control.inicialize_tab(items, null)
	







		
