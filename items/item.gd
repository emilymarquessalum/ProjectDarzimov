extends Control
class_name Item

var itemClass = load("res://items/item_object.gd")
var itemScene = load("res://items/item.tscn")
var data = _get_random_item() 
var slot_parent
var quantity = 1

const possible_items = [
	
	{'item_name' : "Erbs", 'item_description': "Use for potions"
	, 'type': item_type.types.ingredient, 
	'sprite' : preload("res://images.jpg"), 
	'stackable': true, 
	'price' : 3
	},
	{'item_name' : "Onyx Ring", 
	'item_description':"Pure Fashion!",
	'type': item_type.types.equipment, 
	'sprite': preload("res://icon.png"),
	'stackable': false,
	'price':1,},]

# Retorna um item aleatório
func _get_random_item():
	return possible_items[rand_range(0, possible_items.size())]
	
# Retorna item aleatório do (parameter) tipe
func _get_random_item_of_type(type):

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
	#if not data:
	#	data = _get_random_item()
	
	_change_data(data)

# Altera sprite e gera texto se houver quantidade
func _change_data(data):
	if not data:
		return
	
	$sprite.texture = data.sprite
	if data.stackable:
		$quantity.text =  str(quantity)

	
# Retorna uma cópia do item (copies data and quantity)
func _copy():
	var item_copy = itemScene.instance()
	item_copy.data = data
	item_copy.quantity = quantity
	return item_copy
	
# Altera quantidade escrita no texto
func _update_quantity():
	if data.stackable:
		$quantity.text = str(quantity)

