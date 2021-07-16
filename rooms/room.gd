extends Node2D
tool

export(bool) var keep_hints = false
export(int) var room_width = 0
export(int) var room_height =100
export(int) var room_x = 0
export(int) var room_y = 0
export(int) var spawn = 0
export(String) var area_name

var first_entered_in_run = true

# Iniciando texturas dos tiles conforme especificado para a area
func _ready():
	if not Engine.editor_hint:
		Global._change_area()
		

func get_spawn():
	var waypoints =  get_tree().get_nodes_in_group("Waypoint")
	var index = 0
	var waypoint = waypoints[0]
	while waypoint.point != Global.transition_waypoint:
		index += 1
		waypoint = waypoints[index]
	return waypoint

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



