extends Node2D

class_name Item
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var itemClass = load("res://items/item_object.gd")
var itemScene = load("res://items/item.tscn")
var data = random_item()
var quantity = 1
var possible_items 
func random_item():
	possible_items = [load("res://items/erbs.tres"),load("res://items/ring.tres")]
	return possible_items[rand_range(0, possible_items.size())]
	
func random_item_of_type(type):
	possible_items = [load("res://items/erbs.tres"), 
	load("res://items/ring.tres")]
	
	for item in possible_items:
		if item.type == type:
			return item
	return null

func _ready():
	if not data:
		data = random_item()
		
	change_data(data)

func change_data(data):
	$sprite.texture = data.Sprite
	if data.stackable:
		$quantity.text =  str(quantity)

func copy():
	var item_copy = itemScene.instance()
	item_copy.data = data
	return item_copy
	
func update_quantity():
	if data.stackable:
		$quantity.text =  str(quantity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
