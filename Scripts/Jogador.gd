extends KinematicBody2D

const ACIMA = Vector2(0, -1) #Essa constante aqui serve para definir onde está o chão
const GRAVIDADE = 400 #Força da gravidade
const VELOCIDADE = 2500 #Velocidade do personagem
const PULO = -7000 #Força do pulo do personagem 

var movimento = Vector2.ZERO 

func _physics_process(delta): #delta = frames do jogo
	
	_set_animaton()
	#gravidade
	movimento.y+= GRAVIDADE * delta

	#movimentação
	movimento.x = (Input.get_action_strength("d") - Input.get_action_strength("a")) * VELOCIDADE * delta
	
	if Input.is_action_pressed("d"):
		get_node( "Sprite" ).set_flip_h( false )
	elif Input.is_action_pressed("a"):
		get_node( "Sprite" ).set_flip_h( true )
	
	#pulo
	if is_on_floor():
		if Input.is_action_pressed("espaco"):
			movimento.y = PULO * delta

	#resultante de movimento
	movimento = move_and_slide(movimento, ACIMA)

#animação
func _set_animaton():
	var anim = get_node("anim")
	anim = "Parar"
	if movimento.x != 0:
		anim = "Andar"
	if $anim.assigned_animation != anim:
		$anim.play(anim) 




