extends Area2D

onready var particles = $Particles2D
onready var sprite = $Sprite
onready var timer = $Timer

var move = Vector2.ZERO
var look_vec = Vector2.ZERO
var player = null
var speed = 2

func _ready():
	look_vec = player.position - global_position

func _physics_process(delta):
	move = Vector2.ZERO
	move.y = 0
		
	move = move.move_toward(look_vec, delta)
	move = move.normalized() * speed
	position += move
	
	if move.x > 0:
		$Animation.play("RotationR")
	else:
		$Animation.play("RotationL")

func _on_Timer_timeout():
			queue_free()

#func _on_Sword_area_entered(area: Area2D) -> void:
#	sword_entered_something(area)
		
func _on_Sword_body_entered(body):
	sword_entered_something(body)
		
func sword_entered_something(thing):
	if thing.is_in_group("Ground"):
			queue_free()
	elif thing.is_in_group("Parry"):
			queue_free()
	elif thing.is_in_group("Player"):
		player.find_node("Health")._take_damage(1)
		queue_free()
		



