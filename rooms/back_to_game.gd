extends Node

func _ready():
	
	Global.connect("leaving_area", self, "_leave_area",[], CONNECT_ONESHOT)
	
	pass # Replace with function body.

func _leave_area():
	Game._game_on()
