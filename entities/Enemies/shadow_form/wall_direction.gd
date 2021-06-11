extends RayCast2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().connect("_changed_direction", self, "_look_at")
	pass # Replace with function body.

var d = true
func _look_at(dir):
	if d != dir:
		d = dir
	#self.cast_to.x *= -1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
