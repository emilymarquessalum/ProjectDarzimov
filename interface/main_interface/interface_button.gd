extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var shine = false
func _activate_shine():
	shine = true

func _deactivate_shine():
	shine = false
	modulate.b8 = 255
	
var shine_mode = 1
var shine_frames = 0
var speed = 3
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not shine:
		return
	if shine_mode == 1:
		if modulate.b8 + speed >= 255:
			shine_mode = 0
			return
		modulate.b8 += speed
	else:
		if modulate.b8 - speed <= 10:
			shine_mode = 1
			return
		modulate.b8 -= speed	

