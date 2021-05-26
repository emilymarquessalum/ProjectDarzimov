extends Entity

signal life_updated(life)
signal killed()

const GRAVITY = 1000
const SPEED = 5500
const JUMP_FORCE = -12000

onready var invulnerability = $Invunerability
onready var anim = $AnimatedSprite

export var direction = 0
export var damage = 1
var velocity = Vector2()
var jump = 0
var jump_max = 2
var actionTime = false
var flip = false

func _physics_process(delta):
	
	_move(delta)
	_direction()
	
	if actionTime == false:
		_jump(delta)
	
func _die():
	queue_free()

func _move(delta):
	velocity.y+= GRAVITY * delta
	
	if velocity.y < 0 && actionTime == false:
		anim.play("Jump")
	elif Input.is_action_pressed("a") && actionTime == false:
		velocity.x = -SPEED * delta
		anim.play("Walk")
		if flip == true:
			scale.x = -scale.x
			flip = false
	elif Input.is_action_pressed("d") && actionTime == false:
		velocity.x = SPEED * delta
		anim.play("Walk")
		if flip == false:
			scale.x = -scale.x
			flip = true
	else:
		velocity.x = 0
		if actionTime == false:
			anim.play("Idle")
	velocity = move_and_slide(velocity, Vector2.UP)

func _jump(delta):
	if is_on_floor():
		jump = jump_max
	if jump > 0:
		if Input.is_action_just_pressed("space"):
			anim.play("Jump")
			velocity.y = JUMP_FORCE * delta
			jump -= 1	

func do_action(action):
	var act = !actionTime
	if not actionTime:
		anim.play(action)
		actionTime = true
	return act

signal finished_animation()
func _on_AnimatedSprite_animation_finished():
	emit_signal("finished_animation")


func end_action():
	actionTime = false

func _direction():
	direction = (1 if flip else -1)
