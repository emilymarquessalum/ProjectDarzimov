extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _get_cell_at(ent_pos,collision):
	var pos = world_to_map(to_local(ent_pos))
	pos -= collision.normal
	
	var id = get_cellv(pos)
	
	return id
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
