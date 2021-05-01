extends GridContainer

onready var parry = get_tree().get_current_scene().find_node("Player").find_node("Parry")

func _ready():
	for p in parry.parry_clocks:
		var ic = load("res://player/parry_icon.tscn").instance()
		add_child(ic)
		ic.timer = p
		parry.connect("loaded", self, "hide")
		parry.connect("used_parry", self, "show")
	pass

