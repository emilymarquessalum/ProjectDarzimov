extends Enemy

onready var sword = preload("res://Projectiles/Sword/Sword.tscn")
onready var player = null
var velocity = Vector2(0,0)
var speed = 20
var direction = 30

var knock = false
var melee = false

func _ready():
	scale.x = -scale.x
	flip = false
	pass

func _process(delta):
	_move_character()
	if player: 
		_look_at(player.position, false)
	else:
		_detect_ground()	

func _move_character():
	velocity.y = gravity
	
	if player == null:
		velocity.x = (-speed if flip else speed)
	else:
		if melee == true:
			if player.health_control.health <= 1 or health_control.health > 1:
				if (player.position.x - position.x) > 0:
					velocity.x =  (speed * 1.5)
				else:
					 velocity.x =  -(speed * 1.5)
			else:
				if (player.position.x - position.x) > 0:
					velocity.x =  -(speed * 1.5)
				else:
					 velocity.x =  (speed * 1.5)
		else:
			velocity.x = 0
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _detect_ground():
	if not $enemy_properties/GroundDetector.is_colliding() and is_on_floor() and !flip:
		flip = !flip
		scale.x = -scale.x
	#if $GroundDetector.is_colliding() and velocity.x == 0 and is_on_floor() and melee:
	#	flip = !flip
	#	scale.x = -scale.x
		
func _on_PlayerDetector_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _on_PlayerDetector_body_exited(body):
	if body == player:
		player = null

func _throw():
	var sw = sword.instance()
	sw.position = get_global_position()
	sw.player = player
	get_parent().add_child(sw)
	$Timer.set_wait_time(4)
	
func _on_Timer_timeout():
	if player != null and not melee:
		_throw()

func _on_MeleeCombat_body_entered(body):
	if body.is_in_group("Player"):
		pass#melee = true
		# (add a reason for the rogue enemy to even want to go
		# meele first)
	

func _on_MeleeCombat_body_exited(body):
	if body.is_in_group("Player"):
		melee = false


