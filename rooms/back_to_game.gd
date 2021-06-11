extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	Global.connect("leaving_area", self, "_leave_area",[], CONNECT_ONESHOT)
	
	pass # Replace with function body.

func _leave_area():
	Game._game_on()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
