extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

@onready var en = get_parent().get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", Callable(en, "_on_PlayerDetector_body_entered"))
	connect("body_exited", Callable(en, "_on_PlayerDetector_body_exited"))
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
