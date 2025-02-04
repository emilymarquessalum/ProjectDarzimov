@tool
extends property

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_property(data):
	s.position = data["position"]
	s.target_position = data["direction"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
