extends GridContainer

class_name equipped_weapons
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var slotObject = load("res://Inventory/main_inventory/slot.tscn")


	
var main_weapon_slot
var secundary_weapon_slot
func _ready():
	var inventory =  get_tree().get_current_scene().get_node("Inventory")
	main_weapon_slot = inventory.make_slot(self)
	main_weapon_slot.connect("selected_slot", self, "select_allow")
	main_weapon_slot.acceptable_type = item_type.types.weapon
	
	secundary_weapon_slot = inventory.make_slot(self)
	
	secundary_weapon_slot.connect("selected_slot", self, "select_allow")
	secundary_weapon_slot.acceptable_type = item_type.types.weapon


func select_allow(slot,inventory):
	inventory.cancel_slot_click = !inventory.inventory_opened
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
