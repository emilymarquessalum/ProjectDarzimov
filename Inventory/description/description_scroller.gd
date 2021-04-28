extends ScrollContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func change_description(item):
	var v_bar = get_v_scrollbar()
	v_bar.set_value(0)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	var inv = get_tree().get_current_scene().find_node("Inventory")
	
	inv.connect("item_selected", self, "change_description")
	
	get_tree().get_current_scene().connect("child_added_to_main",self, "update_tree")
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_tree():
	var s =get_tree().get_current_scene().get_children().size()
	
	get_tree().get_current_scene().move_child(get_parent(), s)
