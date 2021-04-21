extends ScrollContainer

func change_description(item):
	var v_bar = get_v_scrollbar()
	v_bar.set_value(0)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	var inv = find_parent("Inventory")
	
	inv.connect("item_selected", self, "change_description")
	
	pass 
