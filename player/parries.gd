extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var parry = get_tree().get_current_scene().find_node("Player").find_node("Parry")
# Called when the node enters the scene tree for the first time.
func _ready():
	for p in parry.parry_clocks:
		if p.is_stopped():
			var ic = load("res://player/parry_icon.tscn").instance()
			add_child(ic)
			ic.timer = p
	parry.connect("attempted_parry", self, "parry_attempt")
	pass # Replace with function body.

var timer
func parry_attempt():
	for ic in get_children():
		ic.attempted = true
		
	if timer:
		timer.stop()
		get_parent().remove_child(timer)
	timer = Timer.new()
	timer.wait_time = 2
	timer.connect("timeout", self, "parry_closed")
	get_parent().add_child(timer)
	timer.start()
		
	pass


func parry_closed():
	for ic in get_children():
		ic.attempted = false
