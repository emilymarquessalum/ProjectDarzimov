extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func close_description():
	var descript = get_tree().get_current_scene().find_node("description_panel")
	descript.hide()

func close_description_(slot):
	close_description()
func change_description(slot):
	var descript = get_tree().get_current_scene().find_node("description_panel")
	
	if not slot:
		self.text = ""
		descript.hide()
		return
		
	var item = slot.item
	
	if not item:
		self.text = ""
		descript.hide()
	else:
		self.text = item.data.item_name + ":\n" + item.data.item_description
		descript.show()
		fix_position(descript)

var update = false
func fix_position(descript):
	var m = get_viewport().get_mouse_position()
	descript.rect_position.y = m.y + 5
	descript.rect_position.x = m.x 
	
	update = true
	var s = descript.get_node("Panel")
	if m.x + 80>  get_viewport().get_visible_rect().size.x :
		descript.rect_position.x = m.x - 80


		

	
		
func _ready():
	var inv = get_tree().get_current_scene().find_node("Inventory")
	
	inv.connect("mouse_over_slot", self, "change_description")
	inv.connect("mouse_out_slot", self, "close_description_")
	inv.connect("closed_inventory", self, "close_description")
	inv.connect("interface_closed", self, "close_description")
	inv.connect("interface_opened", get_parent(), "update_tree")
	pass # Replace with function body.

func _process(delta):
	if update:
		update = false
		var descript = get_tree().get_current_scene().find_node("description_panel")
		var panel = descript.get_node("Panel")
		panel.rect_size.y = self.margin_bottom /5

