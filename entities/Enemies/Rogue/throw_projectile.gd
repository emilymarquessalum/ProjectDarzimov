extends "res://entities/behaviour.gd"



onready var sword = preload("res://Projectiles/Sword/Sword.tscn")


func _start_behaviour():
	control.velocity.x = 0
	control.get_node("Timer").start()
	pass
	
	
func _update(delta, en):
	pass

func _throw():
	var sw = sword.instance()
	sw.position = control.get_global_position()
	sw.player = control.player
	control.get_parent().add_child(sw)
	control.get_node("Timer").set_wait_time(4)
	control.get_node("Timer").start()
	
func _on_Timer_timeout():
	if control.player != null and not control.melee:
		_throw()
