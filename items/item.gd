extends Node2D

class_name Item
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var itemClass = load("res://items/item_object.gd")

var data = itemClass.new()
var quantity = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	if randi() % 2 == 0:
		data = load("res://items/erbs.tres");
	else:
		data = load("res://items/axe_item.tres");
	
	$sprite.texture = data.Sprite
	
	if data.stackable:
		$quantity.text =  str(quantity)


func update_quantity():
	if data.stackable:
		$quantity.text =  str(quantity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
