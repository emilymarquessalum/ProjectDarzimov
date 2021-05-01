extends ScrollContainer


 
func _ready():
	get_tree().get_current_scene().connect("child_added_to_main",self, "update_tree")
	
	pass 

func update_tree():
	var s =get_tree().get_current_scene().get_children().size()
	
	get_tree().get_current_scene().move_child(get_parent(), s)
