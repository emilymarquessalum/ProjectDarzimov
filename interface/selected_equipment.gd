extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var equips = get_tree().get_current_scene().find_node("arma_secundaria")
	equips.connect("done_loading", self, "start_interface")
	
	pass # Replace with function body.

func start_interface(slots):
	var i = 0
	for slot in slots:
		var sp = Sprite.new()
		add_child(sp)
		sp.position.x += i * 20
		i += 1
		slot.connect("item_added", self, "change_image", [sp])
		slot.connect("item_removed", self, "remove_image", [sp])
	pass
	

func remove_image(new_item, sprite):
	sprite.texture = null
	

func change_image(new_item, sprite):
	if new_item:
		sprite.texture = new_item.data.Sprite
		var s = new_item.data.Sprite.get_size() #image size
		var scaleto = Vector2(10,10)
		
		var scale = scaleto/s
		sprite.set_scale(scale)
		return
	sprite.texture = null
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
