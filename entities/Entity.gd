extends KinematicBody2D
class_name Entity

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var flip = false
var alive = true
export(int) var speed = 20
onready var health_control = find_node("Health")

var keywords = []
onready var current_state
# Called when the node enters the scene tree for the first time.
func _ready():
	health_control.connect("died", self, "not_alive")
	var updt = get_node("on_update")
	
	if not updt:
		return
	
	for act in updt.get_children():
		behaviours.append(act)
	
	pass # Replace with function body.

signal changed_state(c)
func _change_state(state, data = null):
	state = find_node("states").get_node(state)
	emit_signal("changed_state", self)
	current_state = state
	current_state._start_state(data)


# Move o objeto para cima 
# até que não esteja dentro de um Tile.
# A mudança em cada iteração é um valor 
# arbitrário que eu testei e pareceu ser 
# o melhor entre eficiente e notável
func _fix_on_ground():

	while true:
		var areas = move_and_collide(Vector2.ZERO, true,true,true)
		if not areas:
			break			
		if not areas.collider.is_in_group("Ground"):
			break
		position.y -= 7 

func not_alive():
	alive = false

func _look_at(location, flip_mode):
	if flip_mode:
		if location.x> position.x and !flip:
			flip = !flip
			scale.x = -scale.x
		elif location.x< position.x and flip:
			flip = !flip
			scale.x = -scale.x
		return
	if location.x> position.x and flip:
		flip = !flip
		scale.x = -scale.x
	elif location.x< position.x and !flip:
		flip = !flip
		scale.x = -scale.x
	
	
signal added_keyword(keyword)
func _add_keyword(keyword):

	for k in keywords:
		if k.name == keyword.name:
			k.quantity += keyword.quantity
			emit_signal("added_keyword", k)
			return
	
	keywords.append(keyword)
	emit_signal("added_keyword", keyword)

	
signal removed_keyword(keyword)
func _remove_keyword(keyword):
	var k = null
	for i in range(keywords.size()):	
		if keywords[i].name == keyword.name:
			k = keywords[i]
			if k.quantity <= keyword.quantity:
				keywords.remove(i)
			else:
				k.quantity -= keyword.quantity
			break
	emit_signal("removed_keyword", k)


func keyword_number():
	return keywords.size()

func get_keyword(keyword_name):
	for keyword in keywords:
		if keyword.name == keyword_name:
			return keyword
	return null
	
func _get_direction():
	return 1 if flip else -1

var behaviours = []	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for beh in behaviours:
		beh._update(self)
