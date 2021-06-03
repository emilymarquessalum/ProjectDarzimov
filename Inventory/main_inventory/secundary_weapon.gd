extends Node2D

var done = false
onready var inv = find_parent("Inventory")
var attack 
var itemScene = load("res://items/item.tscn")
onready var player = get_tree().get_current_scene().find_node("Player")
	
func fix_remove(item):
	item.rect_scale = Vector2(1,1)
	Global.equipped_weapon = null
func fix_add(item):
	item.rect_scale = Vector2(4,4)
	Global.equipped_weapon = item.data
	attack = item.data.attack.new()
	attack._set_controller(player)
			

func equipment_action():
	
	if attack == null:
		return
	
	attack.do_action()

signal done_loading(slots)
func _process(delta):
	if Input.is_action_just_pressed("r"):
		equipment_action()
		
	if !done:
		done = true
		var inv_slot = inv._make_slot(self)
		inv_slot.set("custom_styles/panel", load("res://Inventory/main_inventory/new_styleboxflat.tres"))
		inv_slot.rect_scale = Vector2(5.2,2.5)
		
		inv_slot.connect("item_added",self,"fix_add")
		inv_slot.connect("item_removed",self,"fix_remove")
		inv_slot._connect_to_inventory()
		inv_slot.acceptable_type = item_type.types.weapon
		emit_signal("done_loading", inv_slot)
		if Global.equipped_weapon:
			var it = itemScene.instance()
			it.data = Global.equipped_weapon
			attack = it.data.attack.new()
			attack.controller = player
			
			
			
			inv_slot._put_item_into_slot(it)

				
	

	pass
