extends behaviour


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
	if Input.is_action_just_pressed("attack"):
		player.do_action("Attack")
		player.has_done_action = true
		attack_area._attack()
		attack_area.connect("finished_attack",self,"_finish_attack",[player],CONNECT_ONESHOT)
		player._change_state("attacking")
		
func _finish_attack(p):
	
	p._change_state("normal")
