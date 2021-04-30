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
var attempted = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer:
		$Panel.value = (100 - timer.time_left * 100 / timer.wait_time) 
		
	visible =  $Panel.value != 100 or attempted
	
	
	
		
