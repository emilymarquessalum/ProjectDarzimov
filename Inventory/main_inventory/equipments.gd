extends Node2D

var done = false
onready var inv = find_parent("Inventory")
var slots = []
var itemScene = load("res://items/item.tscn")

func fix_remove(item):
	item.rect_scale = Vector2(1,1)
func fix_add(item):
	item.rect_scale = Vector2(4,4)

func equipment_action():
	var item = get_child(0).item
	if not item:
		return
	if item.data.data:
		item.extra_data[0].do_action()

signal done_loading(slots)
func _process(delta):
	if Input.is_action_just_pressed("r"):
		equipment_action()
		
	if !done:
		done = true
		for i in range(1):
			var inv_slot = inv._make_slot(self)
			inv_slot.set("custom_styles/panel", load("res://Inventory/main_inventory/new_styleboxflat.tres"))
			inv_slot.rect_scale = Vector2(5.2,2.5)
			slots.append(inv_slot)
			inv_slot._connect_to_inventory()
			inv_slot.acceptable_type = item_type.types.equipment
			inv_slot.connect("item_added",self,"fix_add")
			inv_slot.connect("item_removed",self,"fix_remove")
			inv_slot.rect_position.x += i * 50
		emit_signal("done_loading", slots)
				
	

	pass
