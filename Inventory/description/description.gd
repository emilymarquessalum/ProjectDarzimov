extends Label

onready var descript = get_tree().get_current_scene().find_node("description_panel")	
var update = false
func _close_description():
	var descript = get_tree().get_current_scene().find_node("description_panel")
	descript.hide()

# isso é meio estúpido, mas eu queria conectar "_close_description"
# com um signal que enviava um slot, e por isso fiz esse caminho entre ele
func _close_description_(slot):
	_close_description()

# qualquer coisa que tiver "_get_description()" pode ser usada
# para abrir uma description
func _change_description(messenger):
	if not messenger:
		descript.hide()
		update = false
		return
	var message = messenger._get_description()
	if not message:
		self.text = ""
		update = false
		descript.hide()
		return
	self.text = message
	descript.show()
	update = true

func _process(delta):
	if update:
		_fix_position(descript)

# mantêm a posição da description de acordo com mouse position
# e altera o tamanho do painel de fundo pelo tamanho do texto
func _fix_position(descript):
	var m = get_viewport().get_mouse_position()
	descript.rect_position.y = m.y - 80
	descript.rect_position.x = m.x -160
	if m.x + 80 > get_viewport().get_visible_rect().size.x :
		descript.rect_position.x = m.x - 240
	
	var panel = descript.get_node("Panel")
	panel.rect_size.y = self.margin_bottom /5

func _connect_to_cards():
	pass

#shotcut pra conectar no inventário
func _connect_to_inventory():
	var inv = get_tree().get_current_scene().find_node("Inventory")
	inv.connect("mouse_over_slot", self, "_change_description")
	inv.connect("mouse_out_slot", self, "_close_description_")
	inv.connect("closed_inventory", self, "_close_description")
	inv.connect("interface_closed", self, "_close_description")
	inv.connect("interface_opened", get_parent(), "_update_tree")
	pass 
