extends  Node2D

class_name tab_

var slots = []
var control
var slot_control
		
func _get_items():
	var items = []
	for slot in slots:
		var item = slot.item
		if item:
			items.append(slot.item)
		slot._take_item_from_slot()
	return items
	
	

func _make_slots(items, controller):
	slot_control = controller
	if slot_control:
		add_child(slot_control)
	var inventory =  get_tree().get_current_scene().find_node("Inventory")
	for i in range(9):
		var slot = inventory._make_slot($container)
		slots.append(slot)
		
		if slot_control:
			if controller.inventory_linked:
				slot._connect_to_inventory()	
			slot_control.get_tab(self)
			slot.connect("gui_input",controller, "_click_call",[slot])
			slot.connect("attempt_to_move_item",controller, "_add_call")
		else:
			slot._connect_to_inventory()
		
		if i < items.size():
			slots[i]._put_item_into_slot(items[i])
		
		
func _open_tab(c, items, controller):
	slots = []
	control = c
	_make_slots(items, controller)
	
	


