extends npc

func _ready():
	pass # Replace with function body.

func _inic_behaviour():
	$Area2D.connect("interacted_object", self, "_start_dialogue")
	
	var sprite_1 = load("res://images.jpg")
	var sprite_2 = load("res://icon.png")
	var talker = {'sprite' : sprite_1}
	var main_character = {'sprite' : sprite_2}
	
	return                                 
	var main_dialogue = dialogue_piece.new()
	main_dialogue.first_character = main_character
	main_dialogue.second_character = talker
	main_dialogue._add_to_lines(["hey there!", "do you agree?"])
	main_dialogue._add_to_lines(["I really hope you do..", "It would be such a waste..."])

	main_dialogue._connect_to_start(["_dialogue"],self)
	
	main_dialogue._connect_to_end(["_open_options"],self)	
	
	var answer_yes = dialogue_piece.new()
	answer_yes.option_name = "yes"
	answer_yes.first_character = main_character
	answer_yes.second_character = talker
	answer_yes._add_to_lines(["I am glad we agree"])
	
	answer_yes._connect_to_end(["_close_dialogue"],self)
	
	var answer_no = dialogue_piece.new()
	answer_no.option_name = "no"
	answer_no.first_character = main_character
	answer_no.second_character = talker
	answer_no._add_to_lines(["....leave!"])
	answer_no._connect_to_end(["_close_dialogue"],self)
	
	main_dialogue.next_opts = [answer_yes, answer_no]
	var opts_1 = [main_dialogue]
	options = [opts_1]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
