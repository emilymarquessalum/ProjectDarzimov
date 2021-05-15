extends npc

var display
var after_display

func _inic_behaviour():
	var sprite_1 = load("res://images.jpg")
	var sprite_2 = load("res://icon.png")
	var necromancer = character.new()
	necromancer.sprite = sprite_1
	var main_character = character.new()
	main_character.sprite = sprite_2
	var dialogue_construct = dialogue_maker.new()
	
	dialogue_construct._define_characters(main_character, necromancer)
	
	var introduction = dialogue_construct._make_dialogue_piece()
	introduction._add_to_lines (["hello there!", "how is your day?"
			],necromancer)
	introduction._add_to_lines(["hello sister. Oh, I am great","other than.. dead and all."],
	main_character)
	introduction._add_to_lines(["that reminds me... I had something for you.", "Where is it..",
			"here! take this card!"],necromancer)
	introduction._start_basic_dialogue(self)
	introduction._connect_to_end( ["_open_card_display"],self)
	
	$Area2D.connect("interacted_object", self, "_start_dialogue")
	
	after_display =  dialogue_construct._make_dialogue_piece()
	after_display._add_to_lines ( ["cool, right? go check your cards now!"]
	,necromancer)
	after_display._start_basic_dialogue(self)
	after_display._end_basic_dialogue(self)
	after_display._connect_to_end(["_wait_for_check"],self)
	after_display.connect("ended", self, "_change_dialogue_pointer",[1])
	
	var opts_1 = []
	opts_1.append(introduction)
	opts_1.append(after_display)
	
	
	var waiting_for_card_check =  dialogue_construct._make_dialogue_piece()
	waiting_for_card_check._add_to_lines(["go on, have a look at it!"],
	necromancer)
	waiting_for_card_check._start_basic_dialogue(self)
	waiting_for_card_check._end_basic_dialogue(self)
	
	var opts_2 = [waiting_for_card_check]
	
	var there_you_go =  dialogue_construct._make_dialogue_piece()
	there_you_go._add_to_lines ( ["Cards give you special powers!","And you can collect more later!"],
	necromancer)
	there_you_go._start_basic_dialogue(self)
	there_you_go._end_basic_dialogue(self)
	there_you_go.connect("ended", self, "_change_dialogue_pointer", [3])
	var opts_3 = [there_you_go]
	
	
	var looped_up =  dialogue_construct._make_dialogue_piece()
	looped_up._add_to_lines(["That was it. Go adventure now or whatever."],
	necromancer)
	looped_up._start_basic_dialogue(self)
	looped_up._end_basic_dialogue(self)
	
	var opts_4 = [looped_up]
	options.append(opts_1)
	options.append(opts_2)
	options.append(opts_3)
	options.append(opts_4)

var text_hint
func _wait_for_check():
	var interface = get_tree().get_current_scene().find_node("interface_control")
	var cards_button = interface.find_node("cards_button")
	cards_button.connect("pressed",self, "_change_dialogue_pointer", [2] , CONNECT_ONESHOT)
	cards_button.connect("pressed",cards_button, "_deactivate_shine", [] , CONNECT_ONESHOT)
	cards_button._activate_shine()
	
	interface.connect("opened_interface", self, "_remove_text_hint",[], CONNECT_ONESHOT)
	text_hint = Label.new()
	text_hint.add_font_override("font",load("res://SmallFont.tres"))
	text_hint.text = "click on esc to check your cards"
	get_tree().get_current_scene().find_node("Camera2D").add_child(text_hint)

func _remove_text_hint():
	get_tree().get_current_scene().remove_child(text_hint)
	text_hint = null



func _open_card_display():
	
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
			_continue_dialogue()
			
