extends Node2D
tool

export(bool) var keep_hints = false
export(int) var room_width = 0
export(int) var room_height =100
export(int) var room_x = 0
export(int) var spawn = 0
export(String) var area_name


var tiles = []
var first_entered_in_run = true

# Iniciando texturas dos tiles conforme especificado para a area
func _ready():
	if not Engine.editor_hint:
		Global._changed_area()
		_look_for_tiles(self)	
		for tile in tiles:
			tile._change_sprite(tile_texture)
			tile._change_region(tile_region)
			tile.bloody_sprite = bloody_tile_texture
			tile.bloody_region = bloody_tile_region


func get_spawn():
	var waypoints =  get_tree().get_nodes_in_group("Waypoint")
	var index = 0
	var waypoint = waypoints[0]
	while waypoint.point != Global.waypoint:
		index += 1
		waypoint = waypoints[index]
	return waypoint

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.editor_hint:
		tiles = []
		_look_for_tiles(self)	
		for tile in tiles:
			tile._change_sprite(tile_texture)
			tile._change_region(tile_region)

	
func _look_for_tiles(parent):
	for obj in parent.get_children():
		if obj.is_in_group("Ground"):
			tiles.append(obj)
		elif obj.get_child_count() > 0:
			_look_for_tiles(obj)
	
	
# editor stuuff:
	
export(bool) var change_tile_on_click
export(Resource) var tile_texture
export(Rect2) var tile_region

export(Resource) var bloody_tile_texture
export(Rect2) var bloody_tile_region

