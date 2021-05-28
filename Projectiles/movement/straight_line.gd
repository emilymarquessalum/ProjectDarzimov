extends Node
class_name straight_line_movement

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var projectile = null
var direction = Vector2.ZERO
var speed = 0 
func _inic(proj, direc, spd):
	projectile = proj
	direction = direc
	speed = spd
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	projectile.position.x += direction.x * speed
	projectile.position.y += direction.y * speed
	
