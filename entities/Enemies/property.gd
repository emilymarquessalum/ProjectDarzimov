extends Node2D
class_name property
tool
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var s = self

func update_property(data):
	s.position = data["position"]
	s.scale = data["scale"]
			

