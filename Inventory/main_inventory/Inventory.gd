extends Node2D

const SlotClass = preload("res://Inventory/main_inventory/slot.gd")
var slotObject = load("res://Inventory/main_inventory/slot.tscn")
var ItemClass = load("res://items/item.tscn")

var selected_item = null
signal item_selected(item)
var last_slot = null

var inventory_slot_holders = []
var holder_class = load("res://Inventory/main_inventory/slot_holder.tscn")
var types = [item_type.types.ingredient, item_type.types.any,
		item_type.types.equipment]
# Called when the node enters the scene tree for the first time.
func _ready():
	for type in types:
		var holder = holder_class.instance()
		holder.type = type
		inventory_slot_holders.append(holder)
		var button = Button.new()
		$button_holder.add_child(button)
		button.text = item_type.types.keys()[type]
		button.theme = Theme.new()
		button.theme.default_font = load("res://interface_text.tres")
		button.connect("pressed", self, "open_holder", [holder])
		add_child(holder)
		holder.visible = false
		holder.rect_position.y += 10
	inventory_slot_holders[0].visible = true
	$inventory_menu.hide()


func open_holder(holder):
	for holder in inventory_slot_holders:
		holder.visible = false
	holder.visible = true

func make_slot(container):
	var inv_slot = slotObject.instance()
	container.add_child(inv_slot)
	inv_slot.acceptable_type = item_type.types.any
	return inv_slot
	
func get_holder_of_type(type):
	for holder in inventory_slot_holders:
		if holder.type == type:
			return holder

	return null
	
func get_slot_with_item_of_type(type):
	var inventory_slots = get_holder_of_type(type)
	
	if not inventory_slots:
		return null
	
	for slot in inventory_slots.get_children():
		if not slot.item:
			continue
			return slot
	return null
	
func add_to_inventory(item):
	var inventory_slots = get_holder_of_type(item.data.type)
	
	open_holder(inventory_slots)
	
	inventory_slots = inventory_slots.get_child(0)
	
	for inv_slot in inventory_slots.get_children():
		if inv_slot.can_stack_item(item):
			inv_slot.item.quantity += item.quantity
			inv_slot.item.update_quantity()
			inv_slot.modulate = Color.yellow
			return	true
	for inv_slot in inventory_slots.get_children():
		if inv_slot.item == null: 
			inv_slot.put_item_into_slot(item)
			inv_slot.modulate = Color.yellow
			return true
	return false
	

	
func item_added(slot):
	selected_item = null
	last_slot = slot


var cancel_slot_click = false

signal mouse_over_slot(slot)
func slot_mouse_over(slot):
	emit_signal("mouse_over_slot", slot)
	if slot.modulate == Color.yellow:
		slot.modulate = Color.white

signal mouse_out_slot(slot)
func mouse_out_slot(slot):
	emit_signal("mouse_out_slot", slot)
	
signal interface_opened()
func interface_opened():
	emit_signal("interface_opened")

signal interface_closed()
func interface_closed():
	emit_signal("interface_closed")
	

		
func unselect_slot():
	last_slot.modulate = Color.white
	slot_mouse_over(null)
	last_slot = null
	selected_item = null

func slot_gui_input(event , slot):
	if event is InputEventMouseButton:
	
		if event.button_index == BUTTON_LEFT and event.pressed:
			slot.emit_signal("selected_slot",slot,self)
		
			if cancel_slot_click:
				cancel_slot_click = false
				return
			if selected_item != null:	
				if slot == last_slot:
					last_slot.emit_signal("double_clicked",last_slot)					
					return
				if slot.attempt_to_add_item(selected_item):
					last_slot.modulate = Color.white
					last_slot = slot
					item_added(slot)
			elif slot.item:
				selected_item = slot.item
				last_slot = slot
				last_slot.modulate = Color.aqua

			emit_signal("item_selected", selected_item)
	



var inventory_opened = false

signal opened_inventory()
func open_inventory():
	var descript = get_tree().get_current_scene().find_node("description_text")
	descript._connect_to_inventory()
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

