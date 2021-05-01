extends Node 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func remove_options():
	for option in $container.get_children():
		$container.remove_child(option)	
	pass

func make_options(options, option_control):
	remove_options()
	for option in options:	
		var new_option = Button.new()
		new_option.text = option.option_name
		
		new_option.connect("pressed", option_control, option.call, [option])
		
		$container.add_child(new_option)


