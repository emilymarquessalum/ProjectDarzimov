extends Node

func _ready():
	
	Global.connect("leaving_area", Callable(self, "_leave_area").bind(), CONNECT_ONE_SHOT)
	
	pass # Replace with function body.

func _leave_area():
	Game._game_on()
