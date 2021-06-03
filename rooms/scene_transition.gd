extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var scene = "null"
export(int) var point = 0
export(bool) var player_direction = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_Area2D_body_entered(body):
	if not body.is_in_group("Player"):
		return
	Global.leave_area()
	var scen = load(scene)
	
	Global.waypoint = point
	Global.player_direction = player_direction
	get_tree().change_scene_to(scen) 
	
	pass # Replace with function body.
