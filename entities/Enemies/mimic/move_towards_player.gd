extends behaviour


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _start_behaviour():
	pass
	
	
func _update(delta, control):
	if (control.player.position.x - control.position.x) > 0:
		control.velocity.x =  (control.speed * 1.5)
	else:
		 control.velocity.x =  -(control.speed * 1.5)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
