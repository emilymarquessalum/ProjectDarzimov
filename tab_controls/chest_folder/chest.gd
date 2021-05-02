extends Node2D
class_name chest

var item = load("res://items/item.tscn")

onready var interact = $chest
var items = []
export(Array, Resource) var items_inside
func _ready():
	
	if items_inside:
		for item_data in items_inside:
			var item_instance = item.instance()
			item_instance.data = item_data
			items.append(item_instance)
	else:
		items.append(item.instance())
		items.append(item.instance())
		items.append(item.instance())
	var inv_control = get_tree().get_current_scene().find_node("interface_control")
	
	interact.connect("interacted_object", self, 
	"_drop_items")


var trinket_class = load("res://items/item_trinket.tscn")
func _drop_items():
	for item in items:
		var item_trink = trinket_class.instance()
		item_trink.position.x = rand_range(0, 15)
		item_trink._inic(item._copy())
		add_child(item_trink)
		
			
