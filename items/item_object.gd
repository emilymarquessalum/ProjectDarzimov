extends Resource

export(String) var item_name
export(String, MULTILINE) var item_description
export(item_type.types) var type
export(Array, Resource) var data

export(Texture) var Sprite
export(bool) var stackable = true
export(int) var price 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
