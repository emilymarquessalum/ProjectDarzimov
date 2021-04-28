extends KinematicBody2D

signal life_updated(life)
signal killed()

const GRAVITY = 1000
const SPEED = 5500
const JUMP_FORCE = -12000

onready var invulnerability = $Invunerability
onready var anim = $Anim
onready var sprite = $Sprite

export var def = 10
export var damage = 0
export var life = 300
var velocity = Vector2()
var jump = 0
var jump_max = 2

func _physics_process(delta):
	
	_move(delta)
	
	_jump(delta)
	
	_flip()
	


func _die():
	queue_free()

func _move(delta):
	velocity.y+= GRAVITY * delta
	velocity.x = (Input.get_action_strength("d") - Input.get_action_strength("a")) * SPEED * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _jump(delta):
	if is_on_floor():
		jump = jump_max
	if jump > 0:
		if Input.is_action_just_pressed("space"):
			velocity.y = JUMP_FORCE * delta
			jump -= 1

func _flip():
	
	if velocity.y < 0:
		anim.play("Jump")
	elif velocity.x > 0:
		anim.play("Walk")
		sprite.flip_h = true
	elif velocity.x < 0:
		anim.play("Walk")
		sprite.flip_h = false
	else:
		anim.play("Idle")
	

