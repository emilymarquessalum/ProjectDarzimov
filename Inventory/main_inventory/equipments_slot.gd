extends Node2D
# slots encontrados em volta do meio do inventário 


onready var inv = find_parent("Inventory")


func _ready():
	var inv_slot = inv._make_slot(self)
	
	inv_slot.set("custom_styles/panel", load("res://Inventory/main_inventory/styles/yellow_circle.tres"))
	inv_slot.rect_scale = Vector2(1.09,0.6)
	inv_slot.acceptable_type = item_type.types.equipment
	inv_slot._connect_to_inventory(inv)
	inv_slot.connect("item_added",self,"fix_add")
	inv_slot.connect("item_removed",self,"fix_remove")		
	pass # Replace with function body.

func fix_remove(item):
	item.rect_scale = Vector2(1,1)
func fix_add(item):
	item.rect_scale = Vector2(4,4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
