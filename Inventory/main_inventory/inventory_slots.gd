extends ScrollContainer


var ItemClass = load("res://items/item.tscn")
var type 
onready var inv = find_parent("Inventory")
var slot_numbers = 50
var slots = []
# Seções de slots do inventário
func _ready():
	for i in range(slot_numbers):
		var inv_slot = inv._make_slot($GridContainer)
		inv_slot._connect_to_inventory()
		slots.append(inv_slot)
		#if randi()%2 == 0:
		#	var item = ItemClass.instance()
		#	item.data = item._get_random_item_of_type(type)
		#	if item.data:
		#		inv_slot._put_item_into_slot(item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
