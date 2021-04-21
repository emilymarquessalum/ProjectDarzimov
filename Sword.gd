extends Area2D

var move = Vector2.ZERO
var look_vec = Vector2.ZERO
var player = null
var speed = 4

func _ready():
	look_vec = player.position - global_position

func _physics_process(delta):
	move = Vector2.ZERO
	move.y = 0
		
	move = move.move_toward(look_vec, delta)
	move = move.normalized() * speed
	position.x += move.x
	
	if move.x > 0:
		$Animation.play("RotationR")
	else:
		$Animation.play("RotationL")

func _on_Timer_timeout():
	queue_free()
