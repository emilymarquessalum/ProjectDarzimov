extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func change_description(item):
	if not item:
		self.text = ""
	else:
		self.text = item.data.item_name + ":\n" + item.data.item_description

# Called when the node enters the scene tree for the first time.
func _ready():
	var inv = find_parent("Inventory")
	
	inv.connect("item_selected", self, "change_description")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
