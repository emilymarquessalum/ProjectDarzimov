extends Node2D
# slot encontrado no meio do inventário para a arma secundária

var done = false
@onready var inv = find_parent("Inventory")
var attack 
var itemScene = load("res://items/item.tscn")
@onready var player = get_tree().get_current_scene().find_child("Player")
	
func fix_remove(item):
	item.scale = Vector2(1,1)
	Global.equipped_weapon = null
func fix_add(item):
	item.scale = Vector2(4,4)
	Global.equipped_weapon = item.data

signal done_loading(slot)
func _process(delta):	
	if !done:
		done = true
		var inv_slot = inv._make_slot(self)
		inv_slot.set("theme_override_styles/panel", load("res://Inventory/main_inventory/styles/gray_circle.tres"))
		inv_slot.scale = Vector2(5.2,2.5)
		
		inv_slot.connect("item_added", Callable(self, "fix_add"))
		inv_slot.connect("item_removed", Callable(self, "fix_remove"))
		inv_slot._connect_to_inventory(inv)
		inv_slot.acceptable_type = item_type.types.weapon
		emit_signal("done_loading", inv_slot)
		if Global.equipped_weapon:
			var it = itemScene.instantiate()
			it.data = Global.equipped_weapon
			attack = it.data.attack.new()
			attack.controller = player
			inv_slot._put_item_into_slot(it)

				
	

	pass
