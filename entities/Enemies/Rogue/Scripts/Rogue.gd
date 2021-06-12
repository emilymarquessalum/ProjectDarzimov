extends Enemy
var direction = 30

var knock = false
var melee = false

func _ready():
	player = null

	tscn_path = "res://entities/Enemies/Rogue/Rogue.tscn"
	scale.x = -scale.x
	flip = false
	Game.enemies.append(self)

func _process(delta):
	if player: 
		_look_at(player.position, false)

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

func _get_direction():
	if flip:
		return -1 * scale.x
	else: 
		return 1  * scale.x
