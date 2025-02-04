extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var equips = get_tree().get_current_scene().find_child("arma_secundaria")
	equips.connect("done_loading", Callable(self, "start_interface"))
	
	pass # Replace with function body.

func start_interface(slot):
	
	
	var sp = Sprite2D.new()
	add_child(sp)
	
	slot.connect("item_added", Callable(self, "change_image").bind(sp))
	slot.connect("item_removed", Callable(self, "remove_image").bind(sp))
	pass
	

func remove_image(new_item, sprite):
	sprite.texture = null
	

func change_image(new_item, sprite):
	if new_item:
		sprite.texture = new_item.data.sprite
		var s = new_item.data.sprite.get_size() #image size
		var scaleto = Vector2(10,10)
		
		var scale = scaleto/s
		sprite.set_scale(scale)
		return
	sprite.texture = null
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
