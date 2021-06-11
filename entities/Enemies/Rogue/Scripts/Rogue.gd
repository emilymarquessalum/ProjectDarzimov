extends Enemy
var direction = 30

var knock = false
var melee = false


func _get_direction():
	
	if flip:
		return -1 * scale.x
	else: 
		return 1  * scale.x
func _ready():
	_change_state("moving")

	tscn_path = "res://entities/Enemies/Rogue/Rogue.tscn"
	scale.x = -scale.x
	flip = false
	Game.enemies.append(self)

func _process(delta):

	_move_character(delta)
	current_state._state_behaviour(delta)
	if player: 
		pass#_look_at(player.position, false)



func _move_character(d):
	velocity.y += 1000*d
	
	if player == null:
		pass
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
		
	
	var current_snap = Vector2.DOWN  * 5
	
	
	
	velocity = move_and_slide_with_snap(velocity, current_snap
	
	, Vector2.UP)


		
func _on_PlayerDetector_body_entered(body):
	if body.is_in_group("Player") and _could_find(body):
		player = body
		_change_state("attacking")

func _on_PlayerDetector_body_exited(body):
	if body == player:
		player = null
		if not alive:
			return
		_change_state("moving")



func _on_MeleeCombat_body_entered(body):
	if body.is_in_group("Player"):
		pass
	

func _on_MeleeCombat_body_exited(body):
	if body.is_in_group("Player"):
		melee = false


