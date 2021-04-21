extends Node2D

const SlotClass = preload("res://Inventory/main_inventory/slot.gd")
var slotObject = load("res://Inventory/main_inventory/slot.tscn")
var ItemClass = load("res://items/item.tscn")
onready var inventory_slots = $inventory_menu/GridContainer
	
var selected_item = null
signal item_selected(item)
var last_slot = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(20):
		var inv_slot = make_slot(inventory_slots)
		if randi()%2 == 0:
			inv_slot.put_item_into_slot(ItemClass.instance())
	$inventory_menu.hide()


func make_slot(container):
	var inv_slot = slotObject.instance()
	container.add_child(inv_slot)
	inv_slot.acceptable_type = item_type.types.any
	return inv_slot
	
func add_to_inventory(item):
	for inv_slot in inventory_slots.get_children():
		if inv_slot.can_stack_item(item):
			inv_slot.item.quantity += item.quantity
			inv_slot.item.update_quantity()
			return	true
	for inv_slot in inventory_slots.get_children():
		if inv_slot.item == null and inv_slot.item_fits(item): 
			inv_slot.put_item_into_slot(item)
			return true
	return false
	
func item_added(slot):
	selected_item = null
	last_slot = slot
	
var cancel_slot_click = false
func slot_gui_input(event , slot):



	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			slot.emit_signal("selected_slot",slot,self)
			if cancel_slot_click:
				cancel_slot_click = false
				return
			if selected_item != null:	
				if slot.attempt_to_add_item(selected_item):
					last_slot.modulate = Color.white
					item_added(slot)
					
			elif slot.item:
				selected_item = slot.item
				last_slot = slot
				last_slot.modulate = Color.aqua

			emit_signal("item_selected", selected_item)
	



var inventory_opened = false
func _process(delta):
	if Input.is_action_just_pressed("open_inventory"):
		if inventory_opened:
			close_inventory()
		else:
			open_inventory()
	pass

signal opened_inventory()
func open_inventory():
	$inventory_menu.show()
	inventory_opened = true
	emit_signal("opened_inventory")

	
signal closed_inventory()
func close_inventory():
	emit_signal("closed_inventory")
	$inventory_menu.hide()
	inventory_opened = false
	if selected_item:
		last_slot.modulate = Color.white
		selected_item = null
		emit_signal("item_selected", selected_item)
