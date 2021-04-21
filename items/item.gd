extends Node2D

class_name Item
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var itemClass = load("res://items/item_object.gd")
var itemScene = load("res://items/item.tscn")
var data = random_item()
var quantity = 1
# Called when the node enters the scene tree for the first time.
func random_item():
	if randi() % 2 == 0:
		return load("res://items/erbs.tres");
	else:
		return load("res://items/axe_item.tres");
	
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
