extends behaviour


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _start_behaviour():

	get_parent().get_parent().deals_damage_on_touch = false
	
	control.get_node("chest").connect("interacted_object", Callable(control, "_mimic_start").bind(), CONNECT_ONE_SHOT)
	
	
	
func _update(delta, control):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
