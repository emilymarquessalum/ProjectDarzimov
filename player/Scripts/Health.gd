extends Node


export var max_health = 3

var health 
signal life_altered(health)
signal player_damaged()
signal player_healed()
func _ready():
	health = max_health
	emit_signal("life_altered", health)
	pass # Replace with function body.

func _take_damage(damage):
	
	var inv = get_parent().get_node("Invunerability")
	
	if inv.time_left != 0:
		return
		
	inv.start()
	health -= damage
	emit_signal("life_altered", health)
	emit_signal("player_damaged")
	
	if health <= 0:
		health = 0
		pass # morrer 
		

	
func _heal_health(heal):
	health += heal
	if health >= max_health:
		health = max_health
	emit_signal("life_altered", health)
	emit_signal("player_healed")

	

func _process(delta):
	if Input.is_action_just_released("q"):
		_take_damage(1)
		
	if Input.is_action_just_released("e"):
		_heal_health(1)
#	pass
