extends behaviour


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _update(delta, player):
	
	if player.velocity.y < 0:
		player.has_done_action = true
		player.anim.play("Jump")
	if player.is_on_floor():
		player.jump = player.jump_max
	if player.jump > 0:
		if Input.is_action_just_pressed("space"):
			player.anim.play("Jump")
			player.velocity.y = player.JUMP_FORCE * delta
			player.jump -= 1


func _start_behaviour():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
