extends Node2D
var inventory_opened = false


var slotObject = preload("res://Inventory/main_inventory/slot.tscn")
var ItemClass = preload("res://items/item.tscn")
var trinket_class = preload("res://Map/chest/item_trinket.tscn")
var holder_class = load("res://Inventory/main_inventory/slot_holder.tscn")

var selected_item = null
var last_slot = null
var cancel_slot_click = false
var inventory_slot_holders = []
var types = [item_type.types.ingredient, item_type.types.any,item_type.types.equipment, item_type.types.weapon]

#Criando as seções do inventário, e seus respectivos botões:
func _ready():
	_build_inventory()
	inventory_slot_holders[0].visible = true
	
	Global.connect("leaving_area", Callable(self, "_globalize_items"))
	_read_items_from_global()
	
	$inventory_menu.hide()
var int_text = preload("res://interface/main_interface/interface_text.tres")
signal finished_loading_inventory()
# lê tipos de itens para criar tudo de forma dinamica!
func _build_inventory():
	for type in types:
		var holder = holder_class.instantiate()
		holder.type = type
		inventory_slot_holders.append(holder)
		var button = Button.new()
		$button_holder.add_child(button)
		button.text = item_type.types.keys()[type]
		button.theme = Theme.new()
		button.theme.default_font = int_text
		button.connect("pressed", Callable(self, "_open_holder").bind(holder))
		add_child(holder)
		holder.visible = false
		holder.position.y += 10
	emit_signal("finished_loading_inventory")
# Salva o que estiver no inventário
# de maneira que a organização pessoal do player não
# seja afetada
func _globalize_items():
	Global.items = []

	for holder in inventory_slot_holders:
		var i = 0
		for slot in holder.slots:
			
			var item_to_add = null
			if not slot.item:
				i += 1
				continue
			
			item_to_add = ItemClass.instantiate()
			item_to_add.data = slot.item.data
			item_to_add.quantity = slot.item.quantity
			var it = {'item' : item_to_add, 'index': i}
			Global.items.append(it)
			i += 1
# lê o conteúdo salvo levando em conta 
func _read_items_from_global():
	var global_items = Global.items

	for g in global_items:
		var it = ItemClass.instantiate()
		it.data = g.item.data
		it.quantity = g.item.quantity
		_add_to_slot(it,g.index)	
	

func _add_item_data_to_inventory(data):
	var it = ItemClass.instantiate()
	it.data = data
	_add_to_inventory(it)

func _add_to_slot(item, index):
	var inventory_slots = _get_holder_of_type(item.data.type)
	inventory_slots.slots[index]._put_item_into_slot(item)



# Abrindo uma seção do inventário:
func _open_holder(holder):
	for holdr in inventory_slot_holders:
		holdr.visible = false
		
	holder.visible = true
	selected_item = null
	_deselect_selected_item()

# Cria e retorna um slot e adicionando ele ao (parameter) container 
func _make_slot(container):
	var inv_slot = slotObject.instantiate()
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
	for slot in inventory_slots.slots:
		if not slot.item:
			continue
			return slot
	return null
	
func _delayed_add_to_inventory(item, new_item = true):
	connect("finished_loading_inventory", Callable(self, "_add_to_inventory").bind(item, new_item))
	
# Tenta adicionar item ao inventário, retorna resultado (true/false)
func _add_to_inventory(item, new_item = true):
	var inventory_slots = _get_holder_of_type(item.data.type)
	_open_holder(inventory_slots)
	#inventory_slots = inventory_slots.get_child(0)
	
	var inv_slot = null
	
	if item.data.stackable:
		inv_slot = _add_item_to_stacked_slot(item, inventory_slots)
		
	if inv_slot == null:
		inv_slot = _add_item_to_empty_slot(item, inventory_slots)
		
	
	if inv_slot == null:
		return false
	
	if new_item:
		#Global.items.append (item.data)
		if inv_slot.can_change_color:
			inv_slot.modulate = Color.YELLOW
	
	return true
	
	
func _add_item_to_empty_slot(item, inventory_slots):
	for inv_slot in inventory_slots.slots:
		if inv_slot.item == null: 
			inv_slot._put_item_into_slot(item)
			return inv_slot	
			
	return null
	
func _add_item_to_stacked_slot(item, inventory_slots):
	for inv_slot in inventory_slots.slots:
		if inv_slot._can_stack_item(item):
			inv_slot.item.quantity += item.quantity
			inv_slot.item._update_quantity()
			return inv_slot
			
	return null
	
	
# Cancela selecionar de um item dentro de um slot
func _deselect_selected_item():
	if last_slot:
		last_slot.modulate = Color.WHITE
	last_slot = null
	selected_item = null
	_slot_mouse_over(null)


signal item_selected(item)
# Global mouse slot functions:
# (usado caso queiramos que algo aconteça quando qualquer slot
# entrar ou sair do mouse, como na descrição!)
signal mouse_over_slot(slot)
func _slot_mouse_over(slot):
	emit_signal("mouse_over_slot", slot)
	if not slot:
		return
	if slot.modulate == Color.YELLOW:
		slot.modulate = Color.WHITE

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
	if not event.pressed:
		return

	if event.button_index == MOUSE_BUTTON_RIGHT and slot.item:
		var item_trink = trinket_class.instantiate()
		get_tree().get_current_scene().add_child(item_trink)
		get_tree().get_current_scene().move_child(self.find_parent("Camera2D"), 
				get_tree().get_current_scene().get_children().size())
		var player = get_tree().get_current_scene().find_child("Player")
		item_trink.position.x = player.position.x
		item_trink.position.y = player.position.y - 20
		item_trink.position.x += randf_range(0, 15)
		item_trink._inic(slot._take_item_from_slot()._copy())
		item_trink.touch_delay = 60
		_deselect_selected_item()
		return
		
	if event.button_index != MOUSE_BUTTON_LEFT:
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
		
		if last_slot.can_change_color:
			last_slot.modulate = Color.AQUA

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
	#var descript = get_tree().get_current_scene().find_node("description_text")
	#descript._connect_to_inventory()
	$inventory_menu.show()
	inventory_opened = true
	emit_signal("opened_inventory")
	AudioControl._change_music("song_s")
	

signal closed_inventory()
func _close_inventory():
	emit_signal("closed_inventory")
	$inventory_menu.hide()
	inventory_opened = false
	if selected_item:
		_deselect_selected_item()
		emit_signal("item_selected", selected_item)
	AudioControl._return_to_last_song()
	
