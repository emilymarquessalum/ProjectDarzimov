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
	var inv = get_tree().get_current_scene().find_node("Inventory")
	chest_control.connect("tab_opened", inv, "open_inventory")
	
	interact.connect("interacted_object", chest_control, 
	"change_tab_state")
	
	chest_control.connect("tab_closed", self, "update_items")
	chest_control.connect("tab_opened",self, "enable_double_click")
	chest_control.inicialize_tab(items, self)
	pass # Replace with function body.

var inventory_linked = true
var last_slot
func click_call(event, slot):
	if not event is InputEventMouseButton:
		return
	if not (event.button_index == BUTTON_LEFT and event.pressed):
		return
	
	if slot == last_slot:
		
		var inv = get_tree().get_current_scene().find_node("Inventory")
		var item = slot.item
		slot.take_item_from_slot()
		if inv.add_to_inventory(item):
			inv.unselect_slot()
		else:
			slot.put_item_into_slot(item)

	else:
		last_slot = slot
		
		
func add_call(slot,item):
	last_slot = null
		
func update_items(new_items):
	items = new_items
	chest_control.inicialize_tab(items, self)
	disable_double_click()
	var inv = get_tree().get_current_scene().find_node("Inventory")
	inv.close_inventory()
	
func enable_double_click():
	var inv =  get_tree().get_current_scene().find_node("Inventory")
	for slot in inv.inventory_slots.get_children():
		slot.connect("double_clicked", self, "add_item_to_chest")
		
func disable_double_click():
	var inv =  get_tree().get_current_scene().find_node("Inventory")
	for slot in inv.inventory_slots.get_children():
		slot.disconnect("double_clicked", self, "add_item_to_chest")
	

func add_item_to_chest(slot):
	chest_control.add_to_tab_items(slot)
	
	var inv = get_tree().get_current_scene().find_node("Inventory")
		
	inv.unselect_slot()
	pass

func get_tab(n_tab):
	pass






		
