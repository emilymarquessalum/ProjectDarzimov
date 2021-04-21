extends KinematicBody2D

signal life_updated(life)
signal killed()

const GRAVITY = 1000
const SPEED = 5500
const JUMP_FORCE = -12000

export (float) var max_life = 250

onready var life = max_life setget _set_life
onready var invulnerability = $Invunerability
onready var anim = $Anim

var velocity = Vector2()
var jump = 0
var jump_max = 2

func _physics_process(delta):
	if anim:
		$Anim.play("Idle")
		print_debug("!")
	else:
		anim = $Anim
	velocity.y+= GRAVITY * delta
	
	velocity.x = (Input.get_action_strength("d") - Input.get_action_strength("a")) * SPEED * delta
	
	if is_on_floor():
		jump = jump_max
	if jump > 0:
		if Input.is_action_just_pressed("space"):
			velocity.y = JUMP_FORCE * delta
			jump -= 1
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
func damage(amount):
	if invulnerability.is_stopped():
		invulnerability.start()
		_set_life(life - amount)
		#anim.play("blink")

func kill():
	pass
	
func _set_life(value):
	var prev_life = life
	life = clamp(value, 0,max_life)
	if life != prev_life:
		emit_signal("life_updated", life)
		if life == 0:
			kill()
			emit_signal("killed")
	
