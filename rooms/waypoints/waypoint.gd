@tool
extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var has_path_parent: bool = true

@export var point: Color = Color.WHITE
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().waypoint_child = self
	
	pass # Replace with function body.
func _process(delta):
	$Sprite2D.modulate = point
	$Sprite2D.visible = Engine.is_editor_hint() or get_tree().get_current_scene().keep_hints
	

func _fix_player_position(player):
	player.global_position= global_position
	
	Global.player_direction = global_position.x - get_parent().global_position.x > 0
	_spawned()
	

func _spawned():
	if has_path_parent:
		get_parent()._spawned()
