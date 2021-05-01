extends GridContainer


var last_health = 0
var heart_tscn = load("res://interface/heart.tscn")
func alterate_interface(health):
	
	while last_health > health:
		last_health -= 1
		remove_child(get_child(0))
	
	
	while last_health < health:
		last_health += 1
		var heart = heart_tscn.instance()
		add_child(heart)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	var health = get_tree().get_current_scene().get_node("Player/Health")
	health.connect("life_altered", self, "alterate_interface")
	alterate_interface(health.health)
	pass




