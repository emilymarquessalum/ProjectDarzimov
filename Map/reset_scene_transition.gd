extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
onready var Player = get_tree().get_current_scene().get_node("Player")

func _on_path1_body_entered(body):
	if body != Player:
		return
		
	var room = Global.current_spawn_point
		
	var scen = load("res://rooms/" + room["area"] + "/" + room["scene"] + ".tscn")
	
	get_tree().change_scene_to(scen) 
	
	
