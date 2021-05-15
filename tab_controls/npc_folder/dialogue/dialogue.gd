extends Control

var lines = []
var current_line
var current_sentence = 0
var end_call
var current_dialogue_piece
signal end_dialogue()

func _make_dialogue(dialogue_lines):
	lines = dialogue_lines
	current_line = 0
	current_dialogue_piece = lines[0]
	$text.text = current_dialogue_piece.text[0]
	$text.percent_visible = 0
	
	$first_character.texture = current_dialogue_piece.first_character_sprite
	$second_character.texture = current_dialogue_piece.second_character_sprite 
	_redraw_current_speaker()
	
func _redraw_current_speaker():
	if current_dialogue_piece.character == current_dialogue_piece.first_character:
		$first_character.modulate.a8 = 255
		$first_character.modulate.r8 = 255
		$first_character.modulate.g8 = 255
		$first_character.modulate.b8 = 255
		$first_character.rect_size = Vector2(25,45)
		$first_character.rect_position.y = -46
		
		$second_character.modulate.a8 = 200
		$second_character.modulate.r8 = 100
		$second_character.modulate.g8 = 100
		$second_character.modulate.b8 = 100
		$second_character.rect_size = Vector2(20,40)
		$second_character.rect_position.y = -41
	else:
		$first_character.modulate.a8 = 200
		$first_character.modulate.r8 = 100
		$first_character.modulate.g8 = 100
		$first_character.modulate.b8 = 100
		$first_character.rect_size = Vector2(20,40)
		$first_character.rect_position.y = -41
		
		$second_character.modulate.a8 = 255
		$second_character.modulate.r8 = 255
		$second_character.modulate.g8 = 255
		$second_character.modulate.b8 = 255
	
		$second_character.rect_size = Vector2(25,45)
		$second_character.rect_position.y = -46
# Clique enquanto em diálogo
func _gui_input(event):
	if not event is InputEventMouseButton:
		return
	if not (event.button_index == BUTTON_LEFT and event.pressed):
		return
	if $text.percent_visible != 1:
		$text.percent_visible = 1
		return
	current_line += 1
	if current_line >= lines[current_sentence].text.size():
		current_line = 0
		current_sentence += 1
		if current_sentence >= lines.size():
			emit_signal("end_dialogue")
			get_tree().get_current_scene().remove_child(self)
			return
		
	current_dialogue_piece = lines[current_sentence]
	
	$first_character.texture = current_dialogue_piece.first_character_sprite
	$second_character.texture = current_dialogue_piece.second_character_sprite
	_redraw_current_speaker()
	
	$text.text = current_dialogue_piece.text[current_line]
	$text.percent_visible = 0

func _process(delta):
	if $text.percent_visible < 1:
		$text.percent_visible += delta
		if $text.percent_visible > 1:
			$text.percent_visible = 1
	pass
