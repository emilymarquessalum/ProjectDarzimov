extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _get_bloody():
	$CollisionShape2D/sprite.region_rect = Rect2(212,311.25,98.7,94.963)
	
	
func _unbloodify():
	$CollisionShape2D/sprite.region_rect = Rect2(6.2,309,101.188,97.094)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
