extends Node
class_name behaviour

@onready var control = get_parent().get_parent()

func _start_behaviour_main(data):
	_start_behaviour()
	
	
func _start_behaviour():
	pass
	
func _update(delta, control):
	pass
