extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text
var item_parent
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var player
func do_action():
	var proj = load("res://Projectiles/projectile.tscn").instance()
	proj.movement = straight_line_movement.new()
	player = item_parent.get_tree().get_current_scene().find_node("Player")
	proj.position = player.position 
	var dir
	if player.flip:
		dir =  Vector2.RIGHT
	else:
		dir = Vector2.LEFT
	proj.movement._inic(proj, dir, 5)
	proj.connect("body_collision", self, "collided")
	item_parent.get_tree().get_current_scene().add_child(proj)
	
	pass



func collided(proj, collider):
	
	if collider.is_in_group("Enemy"):
		pass # this probably means we could try to deal damage to it
		item_parent.get_tree().get_current_scene().remove_child(proj)
		collider.take_damage(2 + player.keyword_number())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
