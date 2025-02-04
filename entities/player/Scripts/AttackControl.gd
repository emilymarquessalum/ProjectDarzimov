extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@onready var player = get_tree().get_current_scene().find_child("Player")
	
@onready var damage = player.damage

func has_target(type):
	return type == "Enemy"

func _attack():
	$AttackColider.disabled = false
	player.connect("finished_animation", Callable(self, "_finish_attack").bind(), CONNECT_ONE_SHOT)

signal finished_attack()
func _finish_attack():
	$AttackColider.disabled = true
	emit_signal("finished_attack")
func _on_AttackArea_body_entered(body):
	pass #if body.is_in_group("Enemy"):
	#	body.health_control._take_damage(self.damage)


	

