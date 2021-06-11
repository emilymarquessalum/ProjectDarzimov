tool
extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	pass # Replace with function body.
	
func _enter_tree():
  set_process_input(true)

var color = Color.webgray
func _draw():
	if Engine.editor_hint:
		draw_rect(Rect2(0,0,100,100), color)


func _update():
	
		color = Color.rebeccapurple
		_draw()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
