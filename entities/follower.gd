extends Entity

var player # as we add more followers, they will not all follow
# the player, but rather follow one another (its like a linked 
# list!) 


func _ready():
	player = get_tree().get_current_scene().find_node("Player")
	pass 
	
var next_y = position.y
var y_speed = 50

func _process(delta):
	var dest = Vector2.ZERO
	if abs(self.position.x - player.position.x) > 30:
		#yield(get_tree().create_timer(0.2), "timeout")
		var y = position.y
		var player_pos = player.position
		player_pos.y = y
		dest = position.move_toward(player_pos, 32) - self.position
		dest.y = y
	
	
	if player.position.y - position.y < -7 and next_y >= 0 and get_node("GroundDetector").is_colliding():
			next_y = -max(y_speed,abs(player.position.y - position.y)+27)
	next_y += y_speed * delta
	
	dest.y = next_y 
	move_and_slide(dest, Vector2.UP)
	
