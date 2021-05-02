extends AnimatedSprite

func _ready():
	var player = get_parent()
	
	player.get_node("Health").connect("player_damaged", self, "_taken_damage")
	
	player.get_node("Invunerability").connect("timeout",self, "_normal_state")

	

func _taken_damage():
	blink = true
	
func _normal_state():
	blink = false
	get_parent().visible = true

var blink = false
var blink_frames = 0
func _process(delta):
	if blink:
		
		blink_frames += 1
		if blink_frames >= 5:
			get_parent().visible = !get_parent().visible
			blink_frames = 0
