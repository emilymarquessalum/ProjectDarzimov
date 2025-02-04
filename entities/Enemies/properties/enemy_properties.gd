@tool
extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var y_start_perception: int = 20
@export var health: int




# Called when the node enters the scene tree for the first time.
func _ready():
	return
	$Health.health = health
	$Health.max_health = health
	pass # Replace with function body.

