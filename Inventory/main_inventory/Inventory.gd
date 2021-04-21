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
		var inv_slot = slotObject.instance()
		inv_slot.init(self)
		inventory_slots.add_child(inv_slot)
		inv_slot.acceptable_type = item_type.types.any
		if randi()%2 == 0:
			inv_slot.put_item_into_slot(ItemClass.instance())
	$inventory_menu.hide()


func add_to_inventory(item):
	for inv_slot in inventory_slots.get_children():
		if inv_slot.can_stack_item(item):
			inv_slot.item.quantity += item.quantity
			inv_slot.item.update_quantity()
			last_slot.remove_child(item)
			return	
	for inv_slot in inventory_slots.get_children():
		if inv_slot.item == null and inv_slot.item_fits(item): 
			last_slot.remove_child(item)
			inv_slot.put_item_into_slot(item)
			return
		
	
	pass
func item_added(slot):
	selected_item = null
	last_slot = slot
func slot_gui_input(event , slot):
	if not inventory_opened:
		return
		
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if selected_item != null:	
				if slot.attempt_to_add_item(selected_item):
					last_slot.modulate = Color.white
					item_added(slot)
					
			elif slot.item:
				selected_item = slot.item
				slot.take_item_from_slot()
				last_slot = slot
				last_slot.modulate = Color.aqua

			emit_signal("item_selected", selected_item)
	


var inventory_opened = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("open_inventory"):
		if inventory_opened:
			$inventory_menu.hide()
			if selected_item:
				last_slot.modulate = Color.white
				add_to_inventory(selected_item)
				selected_item = null
				emit_signal("item_selected", selected_item)
		else:
			$inventory_menu.show()
		inventory_opened = !inventory_opened
	pass
