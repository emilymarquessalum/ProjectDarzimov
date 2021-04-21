extends TextureProgress



# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func alterate_interface(health):
	self.set_value(health) 
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	var health = get_tree().get_current_scene().get_node("Player/Health")
	
	
	health.connect("health_altered", self, "alterate_interface")
	pass # Replace with function body.


