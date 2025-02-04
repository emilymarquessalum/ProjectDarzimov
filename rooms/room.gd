@tool
extends Node2D

@export var keep_hints: bool = false
@export var room_width: int = 0
@export var room_height: int =100
@export var room_x: int = 0
@export var room_y: int = 0
@export var spawn: int = 0
@export var area_name: String

var first_entered_in_run = true

# Iniciando texturas dos tiles conforme especificado para a area
func _ready():
	var screen_x = get_viewport ().get_visible_rect().size.x 
	var screen_y = get_viewport ().get_visible_rect().size.y 
	room_x = $bounds/bound_x.global_position.x + screen_x/2
	room_y = $bounds/bound_y.global_position.y + screen_y/2
	room_width = $bounds/bound_width.global_position.x - screen_x/2
	room_height = $bounds/bound_height.global_position.y - screen_y/2
	
	if not Engine.is_editor_hint():
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



