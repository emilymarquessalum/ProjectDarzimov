extends Node2D
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(bool) var has_path_parent = true

export(Color) var point = Color.white
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().waypoint_child = self
	
	pass # Replace with function body.
func _process(delta):
	$Sprite.modulate = point
	$Sprite.visible = Engine.editor_hint or get_tree().get_current_scene().keep_hints
	

func _fix_player_position(player):
	player.global_position= global_position
	
	Global.player_direction = global_position.x - get_parent().global_position.x > 0
	_spawned()
	

func _spawned():
	if has_path_parent:
		get_parent()._spawned()
