extends GridContainer


var last_health = 0
var heart_tscn = load("res://interface/player_interface/health/heart.tscn")
func _alterate_interface(health):
	
	while last_health > health:
		last_health -= 1
		remove_child(get_child(0))
	
	
	while last_health < health:
		last_health += 1
		var heart = heart_tscn.instantiate()
		add_child(heart)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("changed_area", Callable(self, "_inicialize"))
	


func _inicialize(scn):
	var health_control =  scn.find_child("Player").health_control
	health_control.connect("life_altered", Callable(self, "_alterate_interface"))
	_alterate_interface(health_control.health)
	
