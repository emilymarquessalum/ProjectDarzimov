extends RayCast2D
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


onready var en_p = global_position
onready var p 
onready var p_p
var f = 0
func _process(delta):
	if not Engine.editor_hint:
		return
	f += 1
	
	if f < 60:
		return
	f = 0
	if p == null:
		var scene = get_parent().get_parent().get_parent()
		
		p = scene.find_node("Player")
	if p == null:
		return
	var new_pos = p.global_position - global_position
	var radius = get_parent().find_node("detection_radius").shape.radius
	if p.global_position.distance_to(global_position) > radius:
		new_pos = Vector2.ZERO
	
	
	cast_to = new_pos
	
	force_raycast_update()
	if self.is_colliding():
		modulate.r8 = 0
		modulate.g8 = 0
		modulate.b8 = 200
	else:
		modulate.r8 = 0
		modulate.g8 = 200
		modulate.b8 = 0
		
	
	pass
