@tool
extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

@export var move: bool

@export var override: bool

@export var override_sprite: Resource
@export var override_region: Rect2
# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		Game.floors.append(self)
	
	if not Engine.is_editor_hint() and override:
		for tile in get_children():
			if tile.find_child("sprite"):
				tile.find_child("sprite").texture = override_sprite
				tile.find_child("sprite").region_rect = override_region

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
		var area = t.find_child("Area2D") 
		if area:		
			for c in area.get_overlapping_bodies():
				for g in Game.entity_groups:
					if c.is_in_group(g) and c.is_on_floor() and c.find_child("below_ground_detector").get_collider() == t and not d.has(c):
							
						d.append(c)
						break
						
	
	return d
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		
		if move:
			move = false
			position.x += get_parent().x_plus	
			
			position.y += get_parent().y_plus
		
		
		if override:
			for tile in get_children():
				if tile.find_child("sprite"):
					tile.find_child("sprite").texture = override_sprite
					tile.find_child("sprite").region_rect = override_region
		
