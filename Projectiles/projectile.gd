extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var movement
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if movement:
		movement.update()

signal body_collision(projectile, collider)
func _body_entered(body):
	emit_signal("body_collision", self, body)
	pass # Replace with function body.

signal body_end_collision(projectile, collider)
func _body_exited(body):
	pass # Replace with function body.
