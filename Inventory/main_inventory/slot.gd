extends Panel



var item = null
signal item_added(item)
var acceptable_type

func init(inventory):
	self.connect("gui_input", inventory, "slot_gui_input", [self])

func take_item_from_slot():
	item = null

func item_fits(attempt_item):
	return attempt_item.data.type == acceptable_type or acceptable_type == item_type.types.any

func can_stack_item(attempt_item):
	if item == null:
		return false
	return item.data.stackable and item.data.item_name == attempt_item.data.item_name

func attempt_to_add_item(attempt_item):
	if not item_fits(attempt_item):
		return false
		
	# change inventory's last selected slot to be this
	var slot = find_parent("Inventory").last_slot
	
	
	
	if item == null:
		slot.remove_child(attempt_item)
		put_item_into_slot(attempt_item)
		return true
		
	if can_stack_item(attempt_item):
		item.quantity += attempt_item.quantity
		item.update_quantity()
		slot.remove_child(attempt_item)
		return true
	
	
	var i = item
	take_item_from_slot()
	remove_child(i)
	slot.remove_child(attempt_item)
	slot.put_item_into_slot(i)
	
	put_item_into_slot(attempt_item)
	return true
	
func put_item_into_slot(newItem):
	item = newItem
	add_child(item)
	emit_signal("item_added", item)
	item.position = Vector2(0,0)
	



