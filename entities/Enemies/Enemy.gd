extends Entity
class_name Enemy

export(String) var starting_state = ""
export(int) var health = 3
var ranking = 1
var gravity = 100
var unique_to_scene = true
var tscn_path
var deals_damage_on_touch = true
var velocity = Vector2(0,0)
export(String,MULTILINE) var damage_particle_effect = "res://entities/Enemies/blood.tscn"
onready var player = get_tree().get_current_scene().find_node("Player")
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
	var found = true
	return found
	
	
func _change_direction():

	scale.x = -scale.x

	_changed_direction()
	
onready var particle_effect = load(damage_particle_effect)
func _react_to_attack(health_control):
	var properties = get_node("enemy_properties")
	var en_pos = self.global_position 
	
	var p_e = particle_effect.instance()
	add_child(p_e)
	p_e.global_position = global_position
	behaviours.append(p_e)
	if health_control._life_after_damage_is_taken() <= 0:
		_die()
func _ready():

	
	$Health.health = health
	$Health.max_health = health
	_change_state(starting_state)
	
	$Health.connect("life_damaged", self, "_react_to_attack")
	$Health.connect("died", self, "_die")
	

	


	
func _on_PlayerDetector_body_entered(body):
	if body.is_in_group("Player") and _could_find(body):
		_player_entered_detection(body)

func _on_PlayerDetector_body_exited(body):
	if body.is_in_group("Player"):
		_player_left_detection(body)

func _player_entered_detection(p):
	pass
	
func _player_left_detection(p):
	pass

var override = false
func _physics_process(delta):
	velocity.y += 1000*delta
	
	current_state._state_behaviour(delta)
	
	
	if override:
		override = false
		return
	var current_snap = Vector2.DOWN  * 5
	
	
	
	velocity = move_and_slide_with_snap(velocity, current_snap
	
	, Vector2.UP)
	
