extends Label

func close_description():
	var descript = get_tree().get_current_scene().find_node("description_panel")
	descript.hide()

func close_description_(slot):
	close_description()
	
var d = ""
onready var descript = get_tree().get_current_scene().find_node("description_panel")
	
func change_description(messenger):
	
	if not messenger:
		descript.hide()
		update = false
		return
	

	var message = messenger.get_description()
	if not message:
		self.text = ""
		update = false
		descript.hide()
		return
		
	
	self.text = message
	descript.show()
	
	fix_position(descript)

var update = false
func fix_position(descript):
	var m = get_viewport().get_mouse_position()
	descript.rect_position.y = m.y - 80
	descript.rect_position.x = m.x -160
	
	update = true
	var s = descript.get_node("Panel")
	if m.x + 80>  get_viewport().get_visible_rect().size.x :
		descript.rect_position.x = m.x - 240

func _connect_to_cards():
	pass
		
func _connect_to_inventory():
	var inv = get_tree().get_current_scene().find_node("Inventory")
	
	inv.connect("mouse_over_slot", self, "change_description")
	inv.connect("mouse_out_slot", self, "close_description_")
	inv.connect("closed_inventory", self, "close_description")
	inv.connect("interface_closed", self, "close_description")
	inv.connect("interface_opened", get_parent(), "update_tree")
	pass 

func _process(delta):
	if update:
		fix_position(descript)
		var panel = descript.get_node("Panel")
		panel.rect_size.y = self.margin_bottom /5
