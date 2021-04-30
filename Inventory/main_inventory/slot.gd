extends Panel



var item = null
signal item_added(item)
var acceptable_type
signal selected_slot(slot,inventory)

func connect_to_inventory():
	var inv = get_tree().get_current_scene().find_node("Inventory")
	self.connect("gui_input", inv, "slot_gui_input", [self])
	self.connect("mouse_entered", inv, "slot_mouse_over", [self])
	self.connect("mouse_exited", inv, "mouse_out_slot", [self])

func disconnect_from_inventory_mouse_over():
	self.disconnect("mouse_entered", get_tree().get_current_scene().get_node("Inventory"), "slot_mouse_over")
	self.disconnect("mouse_exited", get_tree().get_current_scene().get_node("Inventory"), "mouse_out_slot")

func get_description():
	if not item:
		return null
	
	return item.data.item_name + ":\n" +item.data.item_description

signal double_clicked(slot)
func move_attempt():
	emit_signal("attempt_to_move_item", self, item)
	var b = move_item
	if not move_item:
		move_item = true
	
	return b

func remove_one():
	item.quantity -= 1
	if item.quantity == 0:
		take_item_from_slot()
	else:
		item.update_quantity()
func take_item_from_slot():
	
	move_attempt()
	remove_child(item)
	var it = item
	item = null
	return it

func item_fits(attempt_item):
	return attempt_item.data.type == acceptable_type or acceptable_type == item_type.types.any

func can_stack_item(attempt_item):
	if item == null:
		return false
	if attempt_item == null:
		return false
	return item.data.stackable and item.data.item_name == attempt_item.data.item_name

signal attempt_to_move_item(slot, item)
var move_item = true
func attempt_to_add_item(attempt_item):
	if not item_fits(attempt_item):
		return false
		
	var slot = get_tree().get_current_scene().find_node("Inventory").last_slot
	
	if not move_attempt():
		modulate = Color.white
		slot.modulate = Color.white
		return false
	

	if not slot.move_attempt():
		slot.modulate = Color.white
		modulate = Color.white
		return false
	
	if item == null:
		slot.take_item_from_slot()
		put_item_into_slot(attempt_item)
		return true
		
	
	if self == slot:
		return
	if can_stack_item(attempt_item):
		item.quantity += attempt_item.quantity
		item.update_quantity()
		slot.take_item_from_slot()
		return true
	
	if not slot.item_fits(item):
		return false
	
	
	var i = item
	take_item_from_slot()
	slot.take_item_from_slot()
	put_item_into_slot(attempt_item)
	
	slot.put_item_into_slot(i)
	
	
	return true
	
func put_item_into_slot(newItem):
	item = newItem
	
	emit_signal("item_added", item)
	if not item:
		return
	add_child(item)
	
	item.position = Vector2(0,0)
	



