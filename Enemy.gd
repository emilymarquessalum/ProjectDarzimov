extends KinematicBody2D

onready var sword = preload("res://Sword.tscn")

var player = null
var flip = true
var gravity = 100
var velocity = Vector2(0,0)
var speed = 20
var direction = 30
var health = 3

func _ready():
	pass

func _process(delta):
	move_character()
	detect_ground()


func move_character():
	velocity.x = (-speed if flip else speed)
	velocity.y = gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)

func detect_ground():
	if not $GroundDetector.is_colliding() and is_on_floor():
		flip = !flip
		scale.x = -scale.x

func _on_PlayerDetector_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _on_PlayerDetector_body_exited(body):
	if body == player:
		player = null

func throw():
	var sw = sword.instance()
	sw.position = get_global_position()
	sw.player = player
	get_parent().add_child(sw)
	$Timer.set_wait_time(2.5)
	
func _on_Timer_timeout():
	if player != null:
		throw()


func _on_HitBox_area_entered(area):
	health -= 1
