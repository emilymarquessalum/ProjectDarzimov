extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var waypoint_child
@export var scene = "null" # (String,MULTILINE)
@export var area = "mountains" # (String,MULTILINE)
func _spawned():
	Global.connect("completed_entered_area", Callable(self, "_fix_enemy_positions").bind(), CONNECT_ONE_SHOT)
	

func _fix_enemy_positions():
	
	for en in Game.enemies:
		
		if not abs(position.x - en.position.x) < 40:
			continue
		var dir = 1
		if not Global.player_direction:
			dir = -1
		en.global_position.x = global_position.x + 60 * dir


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_Area2D_body_entered(body):
	if not body.is_in_group("Player"):
		return
		
	if body.current_state.get_name() == "dead":
		return
		
	Global.leave_area()
	var scen = load("res://rooms/" + area + "/" + scene + ".tscn")
	
	Global.transition_waypoint = waypoint_child.point
	get_tree().change_scene_to_packed(scen) 
	
	pass # Replace with function body.
