extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var parry = get_tree().get_current_scene().find_node("Player").find_node("Parry")
# Called when the node enters the scene tree for the first time.
func _ready():
	for p in parry.parry_clocks:
		var ic = load("res://entities/player/parry_icon.tscn").instance()
		add_child(ic)
		ic.timer = p
		parry.connect("loaded", self, "hide")
		parry.connect("used_parry", self, "show")
	pass # Replace with function body.

