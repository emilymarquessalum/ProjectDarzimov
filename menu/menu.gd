extends Control



func _continue_game_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_exit_game_pressed():
	get_tree().quit()
