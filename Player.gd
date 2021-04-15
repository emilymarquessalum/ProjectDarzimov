extends KinematicBody2D

var direcao_tecla = 0
var direcao = 0

var rapidez_x = 0
var rapidez_y = 0
var velocidade = Vector2()

const VEL_MAX = 7000
const ACC = 6000 #aceleração
const DEC = 10000 #desaceleração
const FORCA_PULO = 6500
const GRAVIDADE = 12000
const DANO = 15

#Status do jogador
var vida_max = 300
var vida = 300
var defesa = 10
var danoArma = 0
var pulo_Max = 2


func _ready():
	set_process(true)
	set_process_input(true)


func _input(event):
	if is_on_floor() == true:
		pulo_Max = 2
	
	if event.is_action_pressed("space") and pulo_Max > 0:
		rapidez_y = -FORCA_PULO
		pulo_Max = pulo_Max - 1
	pass
	
func _process(delta):
	# INPUT
	if direcao_tecla:
		direcao = direcao_tecla
	
	if Input.is_action_pressed("a"):
		direcao_tecla = -1
	elif Input.is_action_pressed("d"):
		direcao_tecla = 1
	else:
		direcao_tecla = 0
	
	# MOVEMENT
	if direcao_tecla == - direcao:
		rapidez_x /= 3
	if direcao_tecla:
		rapidez_x += ACC * delta
	else:
		rapidez_x -= DEC * delta
	rapidez_x = clamp(rapidez_x, 0, VEL_MAX)
	
	if is_on_floor() == false:
		rapidez_y += GRAVIDADE * delta
	if is_on_wall() == true:
		pulo_Max = pulo_Max + 1
		rapidez_y = (GRAVIDADE / 1.2) * delta 
	
	velocidade.x = rapidez_x * delta * direcao
	velocidade.y = rapidez_y * delta
	
	velocidade = move_and_slide(velocidade, Vector2.UP)
