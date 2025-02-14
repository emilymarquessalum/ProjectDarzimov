extends Node

var player_direction = true
var items = []
var equipped_weapon = null: set = _changed_weapon
var item_class = load("res://items/item.tscn")
var play_position = 0
var current_spawn_point = {'room' : "Main", 'area' : "mountains", 'point': Color.RED}
var transition_waypoint = Color.RED
signal changed_weapon(new_weapon)
func _changed_weapon(new):
	equipped_weapon = new
	emit_signal("changed_weapon", new)
	
var to_instance = []
var characters = [{'c_name': "Player", 'health':3}, ]

var to_save_and_load = [CardsData]



func _ready():
	return
	var save_path = "res://save_file.txt" 
	var load_file = File.new()
	
	
	var err = load_file.open(save_path, File.READ)
	if err:
		return
	var test_json_conv = JSON.new()
	test_json_conv.parse(load_file.to_string()).result
	var data = test_json_conv.get_data()
	
	for loader in to_save_and_load:
		loader._inic_data(data)
	
	if data.has("spawn_point"):
		current_spawn_point = data["spawn_point"]



func _save_game():
	
	var save_path = "res://save_file.txt" 
	var load_file = File.new()
	
	
	var err = load_file.open(save_path, File.WRITE)
	if err:
		return
	
	var data = {}
	
	for saver in to_save_and_load:
		data = saver._save_data(data)
	

	
	data["spawn_point"] = current_spawn_point
	
	load_file.store_string(JSON.stringify(data))
		

signal leaving_area()

func leave_area():
	for character in characters:
		var c = get_tree().get_current_scene().find_child(character.c_name)
		character.health = c.find_child("Health")._get_health()
	var r = 0
	for character in to_instance:
		var c =  character.instance
		if c != null :
			character.health = c.find_child("Health")._get_health()
			if character.health == null:
				character.health = 0
		else:
			to_instance.remove(r)
		r+=1
	
	emit_signal("leaving_area")

func _reset():
	to_instance = []
	equipped_weapon = null
	characters = [{'c_name': "Player", 'health':3}, ]
	items = []
	var path = "res://scene_data/"
	var fs = list_files_in_directory(path)
	
	for f in fs:
		var save_file = File.new()
		var err = save_file.open(path + f, File.WRITE_READ)
	
		if err == OK:
			var test_json_conv = JSON.new()
			test_json_conv.parse(save_file.get_as_text())
			var data = test_json_conv.get_data()
			if data:
				data.visited_in_run = false
			else:
				data = {'visited_in_run' : "false"}
			save_file.store_string(JSON.new().stringify(data))
	
func list_files_in_directory(path):
	var files = []
	var dir = DirAccess.new()
	dir.open(path)
	dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547
	
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
	inst.instance.find_child("Health").connect("died", self, 
	"remove", [to_instance.size()])
	to_instance.append(inst)

signal changed_area()
signal completed_entered_area()
func _change_area():
	emit_signal("changed_area", get_tree().get_current_scene())
	var i = 0
	for entity in to_instance:
		continue
		var inst = load(entity.class).instantiate()
		inst.position = get_tree().get_current_scene().get_spawn().position

		get_tree().get_current_scene().add_child(inst)
		
		inst.find_child("Health")._set_health(entity.health)
		entity.instance = inst
		inst.find_child("Health").connect("died", Callable(self, "remove").bind(i))
		inst.position.y += 40+40*i 
		i+= 1
		
	for character in characters:
		var c =get_tree().get_current_scene().find_child(character.c_name)
		c.find_child("Health")._set_health(character.health)
	emit_signal("completed_entered_area")
