extends Node


var max_health = 100
var health
signal life_altered(health)

func _ready():
	health = max_health
	emit_signal("life_altered", health)

	pass # Replace with function body.

func take_damage(damage):
	health -= damage
	emit_signal("life_altered", health)

	if health <= 0:
		health = 0
		pass # morrer 
		

func heal_health(heal):
	health += heal
	emit_signal("life_altered", health)

	if health > max_health:
		health = max_health
	

func _process(delta):
	if Input.is_action_pressed("q"):
		take_damage(1)
		
	if Input.is_action_pressed("e"):
		heal_health(1)
#	pass
