extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

onready var player = get_tree().get_current_scene().find_node("Player")
	
onready var damage = player.damage
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		if player.do_action("Attack"):
			$AttackColider.disabled = false
			player.connect("finished_animation", self, "_finish_attack",[],CONNECT_ONESHOT)


func _finish_attack():
	$AttackColider.disabled = true
	player.end_action()


func _on_AttackArea_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health_control._take_damage(self.damage)
