extends Node2D

class_name Item

var itemClass = load("res://items/item_object.gd")
var itemScene = load("res://items/item.tscn")
var data = random_item()
var quantity = 1

func random_item():
	return load("res://items/erbs.tres");

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
