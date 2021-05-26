extends KinematicBody2D
class_name Entity

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var keywords = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_keyword(keyword_name):
	for keyword in keywords:
		if keyword.name == keyword_name:
			return keyword
	return null
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
