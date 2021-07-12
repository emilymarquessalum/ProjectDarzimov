extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

onready var player = get_tree().get_current_scene().find_node("Player")
	
onready var damage = player.damage

func has_target(type):
	return type == "Enemy"

var translation = 0
func _attack():
	$AttackColider.disabled = false
	player.connect("finished_animation", self, "_finish_attack",[],CONNECT_ONESHOT)

signal finished_attack()
func _finish_attack():
	$AttackColider.disabled = true
	$AttackColider.rotation_degrees = 0
	rot_state = 1
	emit_signal("finished_attack")
func _on_AttackArea_body_entered(body):
	pass #if body.is_in_group("Enemy"):
	#	body.health_control._take_damage(self.damage)
var rot_state = 1
var rotate_frames = 0
func _process(delta):
	
	var rot_degrees = $AttackColider.rotation_degrees
	if $AttackColider.disabled:
		return
	rotate_frames += 1
	if rotate_frames < 5:
		return
	rotate_frames = 0
	if abs(rot_degrees) < 30:
		$AttackColider.rotate(1 * rot_state) 
	else:
		rot_state *= -1
		$AttackColider.rotation_degrees = 0

