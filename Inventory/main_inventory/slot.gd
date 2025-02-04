extends Panel



var item = null
var move_item = true
var acceptable_type

var can_change_color = true
signal item_added(item) # Mudança de item 
signal attempt_to_move_item(slot, item) # Tentativa de adicionar ou remover item
signal selected_slot(slot,inventory) # Slot foi selecionado
signal double_clicked(slot) # Slot foi clicado duas vezes

func _connect_to_inventory(inv):
	self.connect("gui_input", Callable(inv, "_slot_gui_input").bind(self))
	self.connect("mouse_entered", Callable(inv, "_slot_mouse_over").bind(self))
	self.connect("mouse_exited", Callable(inv, "_mouse_out_slot").bind(self))

func disconnect_from_inventory_mouse_over():
	self.disconnect("mouse_entered", Callable(get_tree().get_current_scene().get_node("Inventory"), "_slot_mouse_over"))
	self.disconnect("mouse_exited", Callable(get_tree().get_current_scene().get_node("Inventory"), "_mouse_out_slot"))

# Retorna o texto que será usado na descrição
func _get_description():
	if not item:
		return null
	return item.data.item_name + ":\n" +item.data.item_description

# Interceptar movimento individual de um slot
#(se você conectasse ao "attempt_to_move_item" e mudasse
# "move_item" para falso, ele não moveria o item. Simples assim)
func _move_attempt():
	emit_signal("attempt_to_move_item", self, item)
	var b = move_item
	if not move_item:
		move_item = true
	return b

# Chamado para removar 1 de um item stackable
func _remove_one():
	item.quantity -= 1
	if item.quantity == 0:
		_take_item_from_slot()
	else:
		item._update_quantity()

# Para potencial uso futuro, slots que possam 
#filtrar itens, poderiamos usar isso num sistema de 
#Criação de itens caso necessário. Provavelmente não,
#Mas por enquanto deixa ai!
func _item_fits(attempt_item):
	return attempt_item.data.type == acceptable_type or acceptable_type == item_type.types.any

# Testa se o slot pode receber ++ de algum item
func _can_stack_item(attempt_item):
	if item == null:
		return false
	if attempt_item == null:
		return false
	return item.data.stackable and item.data.item_name == attempt_item.data.item_name


# Testa se possível adicionar um item no slot, retorna resultado true/false
func _attempt_to_add_item(attempt_item):
	if item == null:
		return true
		
	if _can_stack_item(attempt_item):
		return true

	return false
	
# Testa se o item é aceitável para o slot
func _can_move_item_into_slot(attempt_item):
	if not _item_fits(attempt_item):
		return false
	if not _move_attempt():
		modulate = Color.WHITE
		return false
	
	return true

func _put_item_into_slot(new_item):
	
	if _can_stack_item(new_item):
		item.quantity += new_item.quantity
		item._update_quantity()
		return 
	item = new_item
	
	emit_signal("item_added", item)
	if not item:
		return
	item.position = Vector2(0,0)
	item.slot_parent = self
	add_child(item)
	
signal item_removed(item)
# Chamado para remover o item do slot, retorna esse item
func _take_item_from_slot():
	
	_move_attempt()
	remove_child(item)
	var it = item
	emit_signal("item_removed", item)
	item = null
	
	return it


