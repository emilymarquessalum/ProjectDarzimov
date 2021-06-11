extends property
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_property(data):
	.update_property(data)
	s.texture = data["sprite"]
	s.modulate = data["tone"]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
