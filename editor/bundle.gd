@tool
extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

@export var instances: int = 0
@export var instance_rotation: int = 0
@export var d_x: int = 0
@export var d_y: int = 0
@export var rand_x: int
@export var rand_y: int

@export var path: Resource
@export var update: bool = false
@export var dx = [] # (Array,int)
@export var dy = [] # (Array,int)
# Called when the node enters the scene tree for the first time.
func _ready():
	_update()
	pass # Replace with function body.

func _physics_process(delta):
	if update:
		
		if rand_x != 0:
			dx = []
			for i in range(instances):
				dx.append(randi() % rand_x)
		if rand_y != 0:
			dy = []
			for i in range(instances):
				dy.append(randi() % rand_y)
		update = false
		_update()
		
		
func _update():
	for c in get_children():
		remove_child(c)
	for i in range(instances):
		var f = path.instantiate()
		
		f.position.x += d_x * i 
		if dx.size() > i:
			f.position.x += dx[i]
		f.position.y += d_y * i 
		if dy.size() > i:
			f.position.y += dy[i]
		f.rotation_degrees = instance_rotation

		add_child(f)
		f.set_owner(get_tree().get_edited_scene_root())
	
	
	
	
	
