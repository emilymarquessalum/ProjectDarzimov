extends Node 

# classe que representa a tab de opções num dialogo

func _remove_options():
	for option in $container.get_children():
		$container.remove_child(option)	
	pass

func _make_options(options, option_control):
	_remove_options()
	for option in options:	
		var new_option = Button.new()
		new_option.text = option.lines[0]
		new_option.connect("pressed", Callable(option_control, "_dialogue").bind(option))
		$container.add_child(new_option)


