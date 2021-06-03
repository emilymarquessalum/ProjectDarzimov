extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var entity_groups = ["Player", "Enemy"]
var floors = []
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("leaving_area", self, "_leave_area")
	pass # Replace with function body.
func _get_random_floor(floors=floors):
	if floors.size() == 0:
		return null
	return floors[randi()%floors.size()]
	

func _get_random_empty_floor():
	if floors.size() == 0:
		return null
	var temp_floors = floors.duplicate()
	
	for i in range(temp_floors.size()):
		var f = _get_random_floor(temp_floors)
		if f._has_entity_over():
			temp_floors.remove(i)
			continue
		return f
	
	return null

func _leave_area():
	floors = []

	
