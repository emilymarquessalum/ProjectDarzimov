extends Node
class_name justica

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _end_behaviour(_t):
	item.slot_parent._take_item_from_slot()

var item

var itemScene = load("res://items/item.tscn")
var bow = Items.bow
func _start_behaviour(t):
	var inv = t.get_tree().get_current_scene().find_node("Inventory")
	t.get_tree().get_current_scene().find_node("Player")._add_keyword({'name': "Azarado", 'quantity': 1})
	item = itemScene.instance()
	item.data = bow
	inv._add_to_inventory(item)
	
	Global.connect("changed_area", self, "attempt_to_spawn")
	

var spawned_shadow
var base_chance = 10
var chance = base_chance
var max_chance = 50
var chance_increase = 5
var shadow = load("res://entities/Enemies/shadow_form/shadow_form.tscn")
func attempt_to_spawn(_area):
	if spawned_shadow:
		return
	
	var c = randi()%100
	if c > chance:
		chance = base_chance
		spawned_shadow = shadow.instance()
		var shadow_instance = {'s': "res://entities/Enemies/shadow_form/shadow_form.tscn", 
		'health':spawned_shadow.find_node("Health")._get_health(),'s_n':spawned_shadow}	
		Global._add_instance(shadow_instance)
		spawned_shadow = true
	else:
		chance += chance_increase
		if chance > max_chance:
			chance = max_chance
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
