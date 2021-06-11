extends Node

var waypoint = Color.red
var player_direction = true
var cards_d	= [null,null,null]
var items = []
var equipped_weapon = null
var item_class = load("res://items/item.tscn")

var to_instance = []
var characters = [{'c_name': "Player", 'health':3}, ]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
signal leaving_area()

func leave_area():
	for character in characters:
		var c = get_tree().get_current_scene().find_node(character.c_name)
		character.health = c.find_node("Health")._get_health()
	var r = 0
	for character in to_instance:
		var c =  character.s_n
		if c != null :
			character.health = c.find_node("Health")._get_health()
			if character.health == null:
				character.health = 0
		else:
			to_instance.remove(r)
		r+=1
	
	emit_signal("leaving_area")

func _reset():
	to_instance = []
	equipped_weapon = null
	waypoint = Color.red
	characters = [{'c_name': "Player", 'health':3}, ]
	items = []
	var path = "res://scene_data/"
	var fs = list_files_in_directory(path)
	
	for f in fs:
		var save_file = File.new()
		var err = save_file.open(path + f, File.WRITE_READ)
	
		if err == OK:
			var data = parse_json(save_file.get_as_text())
			if data:
				data.visited_in_run = false
			else:
				data = {'visited_in_run' : "false"}
			save_file.store_string(to_json(data))
	
func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
		
	dir.list_dir_end()

	return files
	
func remove(i):
	to_instance.remove(i)

func _add_instance(inst):
	
	inst.s_n.find_node("Health").connect("died", self, 
	"remove", [to_instance.size()])
	to_instance.append(inst)

signal changed_area()
signal completed_entered_area()
func _changed_area():
	emit_signal("changed_area", get_tree().get_current_scene())
	var i = 0
	for scene in to_instance:
		
		var inst = load(scene.s).instance()
		inst.position = get_tree().get_current_scene().find_node("waypoint"+String(waypoint)).position

		get_tree().get_current_scene().add_child(inst)
		
		inst.find_node("Health")._set_health(scene.health)
		scene.s_n = inst
		inst.find_node("Health").connect("died", self, "remove", [i])
		inst.position.y += 40+40*i 
		i+= 1
	for character in characters:
		var c =get_tree().get_current_scene().find_node(character.c_name)
		c.find_node("Health")._set_health(character.health)
	emit_signal("completed_entered_area")
