extends KinematicBody2D

const UP = Vector2(0, -1) 
const GRAVITY = 1000
const SPEED = 5500
const JUMP_FORCE = -12000

var velocity = Vector2()

func _physics_process(delta):

	velocity.y+= GRAVITY * delta
	
	velocity.x = (Input.get_action_strength("d") - Input.get_action_strength("a")) * SPEED * delta
	
	if is_on_floor(): #Verifica se o player está em contato com o chão
		if Input.is_action_pressed("space"):
			velocity.y = JUMP_FORCE * delta
	
	velocity = move_and_slide(velocity, UP)
