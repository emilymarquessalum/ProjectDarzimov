extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

@onready var parry = get_tree().get_current_scene().find_child("Player").find_child("Parry")
# Called when the node enters the scene tree for the first time.
func _ready():
	for p in parry.parry_clocks:
		var ic = load("res://interface/player_interface/parry/parry_icon.tscn").instantiate()
		add_child(ic)
		ic.timer = p
	parry.connect("loaded", Callable(self, "hide"))
	parry.connect("used_parry", Callable(self, "show"))
	pass # Replace with function body.

