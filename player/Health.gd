extends Node


var vida_max = 100
var vida
signal vida_alterada(vida)

func _ready():
	vida = vida_max
	emit_signal("vida_alterada", vida)

	pass # Replace with function body.

func tomar_dano(dano):
	vida -= dano
	emit_signal("vida_alterada", vida)

	if vida <= 0:
		pass # morrer 
		

func regenerar_vida(heal):
	vida += heal
	emit_signal("vida_alterada", vida)

	if vida > vida_max:
		vida = vida_max
	

func _process(delta):
	if Input.is_action_pressed("q"):
		tomar_dano(1)
		
	if Input.is_action_pressed("e"):
		regenerar_vida(1)
#	pass
