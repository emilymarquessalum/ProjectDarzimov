extends behaviour
export(String) var projectile_name = "res://Projectiles/Sword/Sword.tscn"
onready var projectile_class = load(projectile_name)


func _start_behaviour():
	control.velocity.x = 0
	control.get_node("Timer").start()
	pass
	
	
func _update(delta, en):
	pass

func _throw():
	var proj = projectile_class.instance()
	proj.position = control.get_global_position()
	proj.player = control.player
	control.get_parent().add_child(proj)
	control.get_node("Timer").set_wait_time(4)
	control.get_node("Timer").start()
	
func _on_Timer_timeout():
	if control.player != null:
		_throw()
