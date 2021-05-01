extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var sprite = load("res://tileset1.1.jpg")
var empty = load("res://Health.png")

onready var parry = get_tree().get_current_scene().find_node("Parry")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer:
		$Panel.value = (100 - timer.time_left * 100 / parry.parry_timer) 
		
	
	
	
	
		
