extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_self_pressed():
	var inv = get_tree().get_current_scene().get_node("Inventory")
	var rest_items = []
	for item in get_parent().get_items():
		if not inv.add_to_inventory(item):
			rest_items.append(item)

	get_parent().control.close_tab()
	get_parent().control.inicialize_tab(rest_items)
	if rest_items.size() != 0:
		get_parent().control.open_tab()
