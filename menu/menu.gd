extends Control



func _continue_game_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_exit_game_pressed():
	get_tree().quit()


func _on_new_game_pressed():
	pass # Replace with function body.
