extends Entity
class_name Enemy

var ranking = 1
var gravity = 100
var unique_to_scene = true
var tscn_path
var deals_damage_on_touch = true
var speed = 20
var velocity = Vector2(0,0)
onready var player = get_tree().get_current_scene().find_node("Player")
onready var y_start_perception = find_node("enemy_properties").y_start_perception 
func _die():
	queue_free()
	Game.enemies.erase(self)

signal changed_direction(direction)
func _changed_direction():
	emit_signal("changed_direction", scale.x > 0)

func _look_at(a,b):
	._look_at(a,b)
	_changed_direction()
	
#Override to apply more rules to enemy perception 
func _could_find(body):
	var found = abs(global_position.y - body.global_position.y) <= y_start_perception
	
	return found
	
func _fix_on_ground():
	var d = 1
	while true:
		var areas = find_node("middle_area")
		if not areas._inside_floors():
			break
		position.y -= 20 * d
	
func _change_direction():

	scale.x = -scale.x

	_changed_direction()
func _react_to_attack(health_control):
	var tile = get_node("enemy_properties/below_ground_detector").get_collider()
	if tile:
		tile._get_bloody()
	if health_control._life_after_damage_is_taken() <= 0:
		_die()
func _ready():
	_basic_iniciation()
	find_node("Health").connect("life_damaged", self, "_react_to_attack")
	find_node("Health").connect("died", self, "_die")
	

	
func _basic_iniciation():
	var properties = get_node("enemy_properties")
	
	var player_detector = properties.get_node("PlayerDetector")
	player_detector.connect("body_entered", self, "_on_PlayerDetector_body_entered")
	player_detector.connect("body_exited", self, "_on_PlayerDetector_body_exited")
	

	var meele_combat = properties.get_node("MeleeCombat")		
	meele_combat.connect("body_entered", self, "_on_MeleeCombat_body_entered")
	meele_combat.connect("body_exited", self, "_on_MeleeCombat_body_exited")

func _on_PlayerDetector_body_entered(_body):
	pass

func _on_PlayerDetector_body_exited(_body):
	pass

func _on_MeleeCombat_body_entered(_body):
	pass

func _on_MeleeCombat_body_exited(body):
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
