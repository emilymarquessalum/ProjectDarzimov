extends Control

var timer

func _ready():
	pass


@onready var parry = get_tree().get_current_scene().find_child("Parry")

func _process(delta):
	if timer:
		$Panel.value = (100 - timer.time_left * 100 / parry.parry_timer) 
