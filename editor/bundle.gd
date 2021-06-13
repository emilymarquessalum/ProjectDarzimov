extends Node2D
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(int) var instances = 0
export(int) var instance_rotation = 0
export(int) var d_x = 0
export(int) var d_y = 0
export(int) var rand_x
export(int) var rand_y

export(Resource) var path
export(bool) var update = false
export(Array,int) var dx = []
export(Array,int) var dy = []
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
		var f = path.instance()
		
		f.position.x += d_x * i 
		if dx.size() > i:
			f.position.x += dx[i]
		f.position.y += d_y * i 
		if dy.size() > i:
			f.position.y += dy[i]
		f.rotation_degrees = instance_rotation

		add_child(f)
		f.set_owner(get_tree().get_edited_scene_root())
	
	
	
	
	
