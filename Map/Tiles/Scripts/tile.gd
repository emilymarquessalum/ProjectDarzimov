extends StaticBody2D
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bloody_region
var bloody_sprite
var region
var sprite
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _change_sprite(spr):
	find_node("sprite").texture = spr
	sprite = spr
	
	
func return_collision():
	$Area2D.get_overlapping_areas()
	$Area2D.get_overlapping_bodies()
	

func _change_region(reg):
	find_node("sprite").region_rect = reg
	region = reg
	

func _get_bloody():
	
	find_node("sprite").texture = bloody_sprite
	find_node("sprite").region_rect = bloody_region
	
func _unbloodify():
	find_node("sprite").texture = sprite
	find_node("sprite").region_rect = region
