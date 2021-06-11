extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _start_behaviour():
	pass # Replace with function body.


func _update(delta,player):
	var attack_area = player.find_node("AttackArea")
	player._update_has_done_action(not attack_area.get_node("AttackColider").disabled)
	if Input.is_action_just_pressed("attack"):
		player.anim.play("Attack")
		player.has_done_action = true
		attack_area._attack()
		attack_area.connect("finished_attack",self,"_finish_attack",[player],CONNECT_ONESHOT)
		player._change_state("attacking")
		
func _finish_attack(p):
	p._change_state("normal")
