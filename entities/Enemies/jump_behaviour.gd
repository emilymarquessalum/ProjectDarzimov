extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var controller

var jump = false
var jump_frames = 40
var jump_power = 2.4
var jump_max_frames = 40

func _act():
	if controller.find_child("direction_collision").is_colliding() and controller.is_on_floor():
		jump = true
		jump_frames = jump_max_frames
	if jump:
		controller._jump(self)
		jump_frames -= 1
		if jump_frames == 0:
			jump = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
