extends  Node2D

class_name tab_

var slots = []
var slot_control
		
func get_items():
	var items = []
	for slot in slots:
		var item = slot.item
		if item:
			items.append(slot.item)
		slot.take_item_from_slot()
	return items

func make_slots(items, controller):
	slot_control = controller
	if slot_control:
		add_child(slot_control)
	var inventory =  get_tree().get_current_scene().get_node("Inventory")
	for i in range(9):
		var slot = inventory.make_slot($container)
		slots.append(slot)
		
		if slot_control:
			slot_control.get_tab(self)
			slot.connect("selected_slot",controller, "click_call")
			slot.connect("attempt_to_move_item",controller, "add_call")
		if i < items.size():
			slots[i].put_item_into_slot(items[i])
		
func open_tab(items, controller):
	slots = []
	make_slots(items, controller)
	


