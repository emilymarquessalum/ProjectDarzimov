extends Node

func _ready():
	pass # Replace with function body.

func _remove_options():
	for option in $container.get_children():
		$container.remove_child(option)	
	pass

func _make_options(options, option_control):
	_remove_options()
	for option in options:	
		var new_option = Button.new()
		new_option.text = option["name"]
		
		new_option.connect("pressed", option_control, option["call"], [option])
		
		$container.add_child(new_option)
