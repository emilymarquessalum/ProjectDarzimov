extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _update(entity):
	var tiles = move_and_collide(Vector2.ZERO,true,true,true)
	if tiles == null:
		return
	

	if tiles.collider.is_in_group("spikes"):
			entity.health_control._take_damage(1)
