extends Node


# Declare member variables here. Examples:
# var a = 2


# Called when the node enters the scene tree for the first time.
func _start_behaviour():
	get_parent().get_parent().connect("changed_state", self, "_stop_moving", [], CONNECT_ONESHOT)
	pass # Replace with function body.

func _update(delta,player):
	
	if Input.is_action_pressed("a"):
		_move_to(player,-1,delta)
	elif Input.is_action_pressed("d"):
		_move_to(player,1,delta)
	else:
		_stop_moving(player)

func _move_to(player,dir,delta):
	player.velocity.x = player.SPEED * delta * dir
	player.anim.play("Walk")
	player.has_done_action = true
	if player.flip == (dir < 0):
		player.scale.x = -player.scale.x
		player.flip = !player.flip

func _stop_moving(player):
	player.velocity.x = 0
