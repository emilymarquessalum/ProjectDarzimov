extends Control

var timer

func _ready():
	pass

var sprite = load("res://tileset1.1.jpg")
var empty = load("res://Health.png")

onready var parry = get_tree().get_current_scene().find_node("Parry")

func _process(delta):
	if timer:
		$Panel.value = (100 - timer.time_left * 100 / parry.parry_timer) 
