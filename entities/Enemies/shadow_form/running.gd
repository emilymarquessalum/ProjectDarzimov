extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var do = 1
func _update(p):
		p._look_at(p.player.position, false)
		var player_pos = p.player.position
		player_pos.y = p.position.y + p.dest.y
		p.dest.x = p.position.x - p.position.move_toward(player_pos, 60*do).x 
		
		
		if abs(p.position.x -  p.player.position.x) > 50 and p.time_on_state > 60:
			p._change_state(0,"prepare_attack")
			p.health_control.connect("life_damaged", p, "_change_state", ["running"],CONNECT_ONESHOT)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
