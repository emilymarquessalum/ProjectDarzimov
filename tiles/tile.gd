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
	$CollisionShape2D/sprite.texture = spr
	sprite = spr
	


func _change_region(reg):
	$CollisionShape2D/sprite.region_rect = reg
	region = reg
	

func _get_bloody():
	
	$CollisionShape2D/sprite.texture = bloody_sprite
	$CollisionShape2D/sprite.region_rect = bloody_region
	
func _unbloodify():
	$CollisionShape2D/sprite.texture = sprite
	$CollisionShape2D/sprite.region_rect = region
