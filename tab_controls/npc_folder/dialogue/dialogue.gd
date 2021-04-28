extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var lines = []
var current_line
var char_index = 0
var end_call
signal end_dialogue
func make_dialogue(dialogue_lines, dialogue_control,end_calling, par = null):
	
	lines = dialogue_lines
	current_line = 0
	$text.text = lines[0]
	$text.percent_visible = 0
	if par:
		connect("end_dialogue", dialogue_control, end_calling, [par])
	else:
		connect("end_dialogue", dialogue_control, end_calling)
	pass

func _gui_input(event):
	if not event is InputEventMouseButton:
		return
	if not (event.button_index == BUTTON_LEFT and event.pressed):
		return
		
	current_line += 1
	char_index = 0
	if current_line >= lines.size():
		emit_signal("end_dialogue")
		get_tree().get_current_scene().remove_child(self)
		return
		

	$text.text = lines[current_line]
	$text.percent_visible = 0
	pass

func _process(delta):
	if $text.percent_visible < 1:
		$text.percent_visible += delta
		if $text.percent_visible > 1:
			$text.percent_visible = 1
	pass
