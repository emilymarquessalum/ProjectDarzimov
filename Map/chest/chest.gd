extends Node2D
class_name chest

var item = load("res://items/item.tscn")

onready var interact = $chest
var items = []
var scene_index
var items_inside 
var opened = false
func _ready():
	scene_index = Game.chest_index
	Game.chests.append(self)
	var it = Item.new()
	items_inside = [it.possible_items[0],it.possible_items[1]]
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


var trinket_class = load("res://Map/chest/item_trinket.tscn")
func _drop_items():
	if opened:
		return
	opened = true
	for item in items:
		var item_trink = trinket_class.instance()
		item_trink.position.x = rand_range(0, 15)
		item_trink._inic(item._copy())
		add_child(item_trink)
		
			
