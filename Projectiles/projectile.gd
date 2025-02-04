extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var index
var movement
var alive = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$Health.connect("died", Callable(self, "queue_free"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if movement and alive:
		movement.update()

signal body_collision(projectile, collider)
func _body_entered(body):
	
	if not alive:
		return
	emit_signal("body_collision", self, body)
	pass # Replace with function body.

signal body_end_collision(projectile, collider)
func _body_exited(body):
	pass # Replace with function body.


func _on_Area2D_area_entered(area):
	if not alive:
		return
	emit_signal("body_collision", self, area.get_parent())
	
	pass # Replace with function body.
