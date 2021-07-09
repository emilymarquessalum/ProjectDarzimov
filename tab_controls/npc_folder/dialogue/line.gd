extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(String,MULTILINE) var line
export(bool) var first_speaking = true
export(Resource) var first_character_sprite
export(Resource) var second_character_sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
