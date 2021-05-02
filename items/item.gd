extends Node2D
class_name Item

var itemClass = load("res://items/item_object.gd")
var itemScene = load("res://items/item.tscn")
var data = _get_random_item()
var quantity = 1
var possible_items 

func _get_random_item():
	possible_items = [load("res://items/erbs.tres"),load("res://items/ring.tres")]
	return possible_items[rand_range(0, possible_items.size())]
	
func _get_random_item_of_type(type):
	possible_items = [load("res://items/erbs.tres"), 
	load("res://items/ring.tres")]
	var new_possible_items = []
	for item in possible_items:
		if item.type == type:
			new_possible_items.append(item)
	if new_possible_items.size() == 0:
		return null
	if new_possible_items.size() == 1:
		return new_possible_items[0]
	return new_possible_items[int(rand_range(0, possible_items.size()))]

func _ready():
	if not data:
		data = _get_random_item()
		
	_change_data(data)

func _change_data(data):
	$sprite.texture = data.Sprite
	if data.stackable:
		$quantity.text =  str(quantity)

func _copy():
	var item_copy = itemScene.instance()
	item_copy.data = data
	return item_copy
	
func _update_quantity():
	if data.stackable:
		$quantity.text = str(quantity)

