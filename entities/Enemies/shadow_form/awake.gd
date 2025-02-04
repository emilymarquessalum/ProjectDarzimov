extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var d = 0
@onready var s = get_parent().get_parent()
func _update(p):
	d+=2
	p.find_child("Sprite2D").modulate.a8 = d
	s.dest = Vector2.ZERO	
	if d+2>= 255:
		p._change_state(0, "prepare_attack")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
