extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bow = {'item_name' : "Enchanted Bow",
 'item_description': "Gets more powerful the more keywords you have.",
'type' : item_type.types.weapon, 
'attack' : preload("res://items/weapon behaviour/enchanted_bow.gd"),
'sprite': preload("res://items/Axe_Test.png"),
'stackable': false, 
'price': 15}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
