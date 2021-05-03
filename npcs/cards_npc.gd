extends npc

var after_display
func _inic_behaviour():
	var introduction = dialogue_piece.new()
	introduction.lines = ["hello there!", "how is your day?"
			,"oh, right. I had something for you.", "Where is it..",
			"here! take this card!"]
	introduction.end_calls = ["_open_card_display"]
	introduction.calls.append("_change_camera")
	$Area2D.connect("interacted_object", self, "_dialogue",[introduction])
	after_display = dialogue_piece.new()
	after_display.lines = ["cool, right? go check your cards now!"]
	after_display.calls.append("_change_camera")
	after_display.end_calls = ["_close_dialogue", "_change_camera_back"]
	options = []
	options.append(introduction)
	options.append(after_display)
	_start_dialogue_behaviour()

func _change_camera():
	var camera = get_tree().get_current_scene().find_node("focus_camera")
	var player= get_tree().get_current_scene().find_node("Player")
	camera.make_current()
	camera.offset.x = player.position.x
	camera.offset.y = player.position.y -130
	
	dialogue.rect_scale = Vector2(0.8, 0.6)
	dialogue.rect_position.y += 40
	dialogue.rect_position.x = player.position.x - 36
	
func _change_camera_back():
	var camera = get_tree().get_current_scene().find_node("Camera2D")
	camera.make_current()
var display
func _open_card_display():
	can_close = false
	_change_camera_back()
	display = load("res://npcs/item_display.tscn").instance()
	get_tree().get_current_scene().add_child(display)
	display.connect("finished_animation", self, "_listen_to_continuation")
	display.grow_speed = 3
	display._change_image(card.sprite)
	
var check_for_display_click = false
var card = load("res://cards/lion.tres")
func _listen_to_continuation():
	check_for_display_click = true
	var cards = get_tree().get_current_scene().find_node("Cards")
	cards.change_card(card)

func _process(delta):
	if check_for_display_click:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			check_for_display_click = false
			display.get_parent().remove_child(display)
			_dialogue(after_display)
			
