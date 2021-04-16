extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var slotObject = load("res://Inventory/main_inventory/slot.tscn")

func make_slot():
	var inv_slot = slotObject.instance()
	inv_slot.init(get_parent())
	self.add_child(inv_slot)
	#inv_slot.connect("gui_input", get_parent().get_node("Inventory"), "slot_gui_input", [inv_slot])
	inv_slot.acceptable_type = item_type.types.weapon
	return inv_slot
	
var main_weapon_slot
var secundary_weapon_slot
func _ready():
	main_weapon_slot = make_slot()
	secundary_weapon_slot = make_slot()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
