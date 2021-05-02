extends Node2D
var inventory_opened = false

const SlotClass = preload("res://Inventory/main_inventory/slot.gd")
var slotObject = load("res://Inventory/main_inventory/slot.tscn")
var ItemClass = load("res://items/item.tscn")
var selected_item = null
signal item_selected(item)
var last_slot = null
var cancel_slot_click = false
var inventory_slot_holders = []
var holder_class = load("res://Inventory/main_inventory/slot_holder.tscn")
var types = [item_type.types.ingredient, item_type.types.any,
		item_type.types.equipment]

#Criando as seções do inventário, e seus respectivos botões:
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
		button.connect("pressed", self, "_open_holder", [holder])
		add_child(holder)
		holder.visible = false
		holder.rect_position.y += 10
	inventory_slot_holders[0].visible = true
	$inventory_menu.hide()

# Abrindo uma seção do inventário:
func _open_holder(holder):
	for holder in inventory_slot_holders:
		holder.visible = false
	holder.visible = true
	selected_item = null
	_deselect_selected_item()

# Cria e retorna um slot e adicionando ele ao (parameter) container 
func _make_slot(container):
	var inv_slot = slotObject.instance()
	container.add_child(inv_slot)
	inv_slot.acceptable_type = item_type.types.any
	return inv_slot
	
# Retorna a seção do inventário do (parameter) tipo 
func _get_holder_of_type(type):
	for holder in inventory_slot_holders:
		if holder.type == type:
			return holder
	return null
	
# Retorna slot vazio do (parameter) type
func _get_slot_with_item_of_type(type):
	var inventory_slots = _get_holder_of_type(type)
	if not inventory_slots:
		return null
	for slot in inventory_slots.get_children():
		if not slot.item:
			continue
			return slot
	return null
	
# Tenta adicionar item ao inventário, retorna resultado (true/false)
func _add_to_inventory(item):
	var inventory_slots = _get_holder_of_type(item.data.type)
	_open_holder(inventory_slots)
	inventory_slots = inventory_slots.get_child(0)
	for inv_slot in inventory_slots.get_children():
		if inv_slot._can_stack_item(item):
			inv_slot.item.quantity += item.quantity
			inv_slot.item._update_quantity()
			inv_slot.modulate = Color.yellow
			return	true
	for inv_slot in inventory_slots.get_children():
		if inv_slot.item == null: 
			inv_slot._put_item_into_slot(item)
			inv_slot.modulate = Color.yellow
			return true
	return false
	
# Cancela selecionar de um item dentro de um slot
func _deselect_selected_item():
	if last_slot:
		last_slot.modulate = Color.white
	last_slot = null
	selected_item = null
	_slot_mouse_over(null)

# Global mouse slot functions:
# (usado caso queiramos que algo aconteça quando qualquer slot
# entrar ou sair do mouse, como na descrição!)
signal mouse_over_slot(slot)
func _slot_mouse_over(slot):
	emit_signal("mouse_over_slot", slot)
	if not slot:
		return
	if slot.modulate == Color.yellow:
		slot.modulate = Color.white

signal mouse_out_slot(slot)
func _mouse_out_slot(slot):
	emit_signal("mouse_out_slot", slot)



signal interface_opened()
func _interface_opened():
	emit_signal("interface_opened")

signal interface_closed()
func _interface_closed():
	emit_signal("interface_closed")



# slot mouse click function
func _slot_gui_input(event , slot):
	if not event is InputEventMouseButton:
		return
	if not (event.button_index == BUTTON_LEFT and event.pressed):
		return

	slot.emit_signal("selected_slot",slot,self)
	if cancel_slot_click:
		cancel_slot_click = false
		return
	if selected_item != null:	
		if slot == last_slot:
			last_slot.emit_signal("double_clicked",last_slot)					
			_deselect_selected_item()
			return
	
		if try_to_move_item(slot):
			_deselect_selected_item()	
	elif slot.item:
		selected_item = slot.item
		last_slot = slot
		last_slot.modulate = Color.aqua

	emit_signal("item_selected", selected_item)


# Tentativa de mover selected item
func try_to_move_item(slot):
	var can_move_item = slot._can_move_item_into_slot(selected_item)
	if not can_move_item:
		return false
		
	# só retorna verdade se o item for o mesmo stackable
	#ou se o slot estiver vazio:
	var can_add_item = slot._attempt_to_add_item(selected_item)			
	if can_add_item:
		slot._put_item_into_slot(last_slot._take_item_from_slot())
		return true
	
	# A partir daqui vem a tentativa de mover itens de
	#slot para outro:
	if not last_slot:
		return false
	if last_slot._can_move_item_into_slot(slot.item):
		var it = slot._take_item_from_slot()
		slot._put_item_into_slot(last_slot._take_item_from_slot())
		last_slot._put_item_into_slot(it)
		return true
	return false

# abrir e fechar inventário:
signal opened_inventory()
func _open_inventory():
	var descript = get_tree().get_current_scene().find_node("description_text")
	descript._connect_to_inventory()
	$inventory_menu.show()
	inventory_opened = true
	emit_signal("opened_inventory")
	
signal closed_inventory()
func _close_inventory():
	emit_signal("closed_inventory")
	$inventory_menu.hide()
	inventory_opened = false
	if selected_item:
		_deselect_selected_item()
		emit_signal("item_selected", selected_item)

