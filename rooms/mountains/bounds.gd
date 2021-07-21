extends Node2D
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Color) var bound_color = Color.blue
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	if not Engine.editor_hint:
		return
	var r = Rect2($bound_x.position.x, $bound_y.position.y, $bound_width.position.x-$bound_x.position.x, $bound_height.position.y-$bound_y.position.y)

	draw_rect(r, bound_color)

export(bool) var redraw = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if redraw:
		redraw = false
		update()
