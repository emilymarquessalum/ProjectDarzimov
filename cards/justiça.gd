extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _end_behaviour(t):
	item.slot_parent._take_item_from_slot()

var item

var itemScene = load("res://items/item.tscn")
var bow = preload("res://items/enchanted_bow.tres")
func _start_behaviour(t):
	var inv = t.get_tree().get_current_scene().find_node("Inventory")
	var player = t.get_tree().get_current_scene().find_node("Player")
	player._add_keyword({'name': "Azarado", 'quantity': 1})
	item = itemScene.instance()
	item.data = bow
	inv._add_to_inventory(item)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
