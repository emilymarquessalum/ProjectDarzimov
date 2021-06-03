extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text
var item_parent
var controller
var target_groups = ["Enemy", "Enemy Arrow"]
var arrow_groups = ["arrow", "Player Arrow"]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _set_controller(c):
	controller = c



func do_action():
	var proj = load("res://Projectiles/projectile.tscn").instance()
	proj.movement = straight_line_movement.new()
	proj.position = controller.position 
	for group in arrow_groups:
		proj.add_to_group(group)
	var dir
	if controller.flip:
		dir =  Vector2.RIGHT
	else:
		dir = Vector2.LEFT
	proj.movement._inic(proj, dir, 5)
	
	proj.connect("body_collision", self, "collided")

	controller.get_tree().get_current_scene().add_child(proj)
	
	pass



func collided(proj, collider):
	if not collider:
		return
	for group in target_groups:
		if collider.is_in_group(group):
			
			
			if collider.alive:
				proj.alive = false
				#proj.get_parent().remove_child(proj)
				proj.queue_free()
				collider.find_node("Health")._take_damage(2 + controller.keyword_number())
		
			break

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
