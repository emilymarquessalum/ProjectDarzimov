extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

@export var line # (String,MULTILINE)
@export var first_speaking: bool = true
@export var first_character_sprite: Resource
@export var second_character_sprite: Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
