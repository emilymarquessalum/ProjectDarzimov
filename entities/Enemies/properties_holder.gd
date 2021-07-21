extends Node2D
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

export(bool) var update_properties
func _process(delta):
	if not update_properties:
		return
	update_properties = false
	
	_duplicate_elements(self, get_parent())
func _duplicate_elements(own, new_own):
	
	for n in own.get_children():
		if get_parent().get_node(n.name):
			continue
		var node_clone = _create_proper_duplicate(n, new_own)
	
		_duplicate_elements(n, node_clone)
				
func _create_proper_duplicate(node, parent):
	var node_clone = node.duplicate(4)
	parent.add_child(node_clone)
	node_clone.owner = get_parent()
	return node_clone
