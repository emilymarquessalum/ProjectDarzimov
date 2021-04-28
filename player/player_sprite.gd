extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_parent()
	
	player.get_node("Health").connect("player_damaged", self, "taken_damage")
	
	player.get_node("Invunerability").connect("timeout",self, "normal_state")

	

func taken_damage():
	modulate = Color.red
	
func normal_state():
	modulate = Color.white
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
