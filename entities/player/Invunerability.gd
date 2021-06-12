extends Timer


onready var player = get_parent()
func _test_for_invulnerability(health_control):
	if player._is_invulnerable():
		health_control.can_take_damage = false
		return
	player.set_collision_mask(0b00000000000000000001)
	start()

func _on_Invunerability_timeout():
	player.get_node("AnimatedSprite")._normal_state()
	player.set_collision_mask(0b00000000000000000011)
	player._test_for_enemy_col()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
