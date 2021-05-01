extends Node2D

class_name chest

var item = load("res://items/item.tscn")

onready var interact = $chest
var items = []

func _ready():
	items.append(item.instance())
	items.append(item.instance())
	items.append(item.instance())
	
	var inv_control = get_tree().get_current_scene().find_node("interface_control")
	
	interact.connect("interacted_object", self, 
	"drop_items")

var trinket_class = load("res://items/item_trinket.tscn")
func drop_items():
	for item in items:
		var item_trink = trinket_class.instance()
		item_trink.position.x = rand_range(0, 15)
		item_trink.inic(item)
		add_child(item_trink)
		item_trink.connect("collided", self, "collision")

func collision(trinket, obj):
	if obj.is_in_group("Ground") and trinket.moving:
		trinket.moving = false
		trinket.position.y -= 5
		return
	if obj.is_in_group("Player") and not trinket.moving and not trinket.animate:
		trinket.animate = true
		trinket.connect("finished_animation", self, "trinket_finished_animation")
		
func trinket_finished_animation(trinket):
	var inv = get_tree().get_current_scene().find_node("Inventory")
	if inv.add_to_inventory(trinket.item):
		remove_child(trinket)
			
