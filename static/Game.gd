extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var entity_groups = ["Player", "Enemy", "Follower"]
var floors = []
var enemies = []
var chests = []
var chest_index = 0: get = get_c_index

func get_c_index():
	chest_index += 1
	return chest_index - 1
	
func _ready():
	_game_on()
	
func _game_on():
	Global.connect("leaving_area", Callable(self, "_leave_area"))
	Global.connect("changed_area", Callable(self, "_enter_area"))
	
	
func game_off():
	Global.disconnect("leaving_area", Callable(self, "_leave_area"))
	Global.disconnect("changed_area", Callable(self, "_enter_area"))
	floors = []
	enemies = []
	chests = []
	get_tree().get_current_scene().find_child("Camera2D").on = false
	
func _get_random_floor(floors=floors):
	if floors.size() == 0:
		return null
	return floors[randi()%floors.size()]
	

func _get_random_empty_floor():
	if floors.size() == 0:
		return null
	var temp_floors = floors.duplicate()
	
	for i in range(temp_floors.size()):
		var f = _get_random_floor(temp_floors)
		if f._has_entity_over():
			temp_floors.remove(i)
			continue
		return f
	
	return null


func _enter_area(t):
	var save_path = "res://scene_data/" + get_tree().get_current_scene().area_name
	var load_file = File.new()
	
	
	var err = load_file.open(save_path, File.READ)
	if err:
		return
	
	var test_json_conv = JSON.new()
	test_json_conv.parse(load_file.get_as_text())
	var data = test_json_conv.get_data()
	if not data:
		return
	if not data.has("visited_in_run") or not data.visited_in_run:
		return
	
	get_tree().get_current_scene().first_entered_in_run = false
	if data.has("opened_chests"):	
		for index in data.opened_chests:
			chests[index].opened = true
		
	# This will be replaced if/when we make 
	#so that enemies spawn randomly, that will be 
	#what we should interrupt
	if data.has("enemies"):
		for en in enemies:
			if not en.unique_to_scene:
				continue
			en._die()
		enemies = []
		for en_d in data.enemies:
			var en = load(en_d.enemy_type).instantiate()
			get_tree().get_current_scene().get_node("Enemies").add_child(en)
			en.position.x = en_d.x
			en.position.y = en_d.y

func _leave_area():
	var save_path = "res://scene_data/" + get_tree().get_current_scene().area_name
	var save_file = File.new()
	
	
	var err = save_file.open(save_path, File.WRITE)
	if err:
		return
	
	
	var data = {'visited_in_run' : "true", 
	'enemies': [],
	'opened_chests': []}
	
	
	for en in enemies:
		if not en.unique_to_scene:
			continue
		data.enemies.append({
			'enemy_type': en.tscn_path,
			'x': en.position.x, 
			'y': en.position.y})
	
	
	# Since the number of chests and their loading 
	#order doesnt change, we can mark which ones 
	#were opened by a self-incrementing-index 
	for chest in chests:
		if not chest.opened:
			continue
		data.opened_chests.append(chest.scene_index)
	
	
	if err == OK:
		save_file.store_string(JSON.new().stringify(data))
	else:
		print("error")
	
	
	
	floors = []
	enemies = []
	chests = []
	chest_index = 0
	
