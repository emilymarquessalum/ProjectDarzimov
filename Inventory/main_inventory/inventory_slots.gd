extends ScrollContainer


var ItemClass = load("res://items/item.tscn")
var type 
onready var inv = find_parent("Inventory")
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(50):
		var inv_slot = inv.make_slot($GridContainer)
		inv_slot.connect_to_inventory()
		if randi()%2 == 0:
			var item = ItemClass.instance()
			item.data = item.random_item_of_type(type)
			if item.data:
				inv_slot.put_item_into_slot(item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
