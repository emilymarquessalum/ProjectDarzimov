extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _save():
	var save_file = File.new()
	var err = save_file.open("user//:save.txt", File.WRITE)
	var data = []
	if err == OK:
		save_file.store_string(JSON.new().stringify(data))
	else:
		print("error")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
