extends Node
class_name dialogue_reader

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _return_data(file_name):

	var file = File.new()
	
	assert( file.file_exists(file_name) )
	
	
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
