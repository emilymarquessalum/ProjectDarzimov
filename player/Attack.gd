extends Area2D

func _ready():
	pass 

onready var player = get_parent()

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		if player.do_action("Attack"):
			$AttackColider.disabled = false
			player.connect("finished_animation", self, "finish_attack",[],CONNECT_ONESHOT)

func finish_attack():
	$AttackColider.disabled = true
	player.end_action()
