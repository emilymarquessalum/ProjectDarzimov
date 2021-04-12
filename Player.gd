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

var vida = 100
var defesa = 10
var dano = 30


func _ready():
	set_process(true)
	set_process_input(true)


func _input(event):
	if event.is_action_pressed("space"):
		rapidez_y = -FORCA_PULO
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
	
	rapidez_y += GRAVIDADE * delta
	
	velocidade.x = rapidez_x * delta * direcao
	velocidade.y = rapidez_y * delta
	move_and_slide(velocidade)

