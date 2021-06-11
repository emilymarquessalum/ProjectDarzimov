extends Node2D
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(bool) var override
export(Resource) var override_sprite
export(Rect2) var override_region
# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.editor_hint:
		Game.floors.append(self)
	
	if not Engine.editor_hint and override:
		for tile in get_children():
			if tile.find_node("sprite"):
				tile.find_node("sprite").texture = override_sprite
				tile.find_node("sprite").region_rect = override_region

	pass # Replace with function body.

func _has_entity_over():
	for c in $area.get_overlapping_areas():
		for g in Game.entity_groups:
			if c.is_in_group(g):
				return true
	for c in $area.get_overlapping_bodies():
		for g in Game.entity_groups:
			if c.is_in_group(g):
				return true
	return false
	
func _entities_over():
	var d = []
	for t in get_children():
		var area = t.find_node("Area2D") 
		if area:		
			for c in area.get_overlapping_bodies():
				for g in Game.entity_groups:
					if c.is_in_group(g) and c.is_on_floor() and c.find_node("below_ground_detector").get_collider() == t and not d.has(c):
							
						d.append(c)
						break
						
	
	return d
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.editor_hint:
		if override:
			for tile in get_children():
				if tile.find_node("sprite"):
					tile.find_node("sprite").texture = override_sprite
					tile.find_node("sprite").region_rect = override_region
		
