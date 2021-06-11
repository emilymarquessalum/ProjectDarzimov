extends "res://entities/state.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _state_behaviour(delta):
	behaviour.get_node("throw_projectile")._update(delta, get_parent().get_parent())

