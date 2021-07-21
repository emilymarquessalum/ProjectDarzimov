extends Node2D
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var y_start_perception = 20
export(int) var health




# Called when the node enters the scene tree for the first time.
func _ready():
	return
	$Health.health = health
	$Health.max_health = health
	pass # Replace with function body.

