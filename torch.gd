extends Light2D
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Array,float) var goals = []
export(float) var speed = 0.1
export(bool) var stop = false
var index = 0

export(float) var multiply_by
export(bool) var multiply
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if multiply:
		multiply = false
		for i in range(goals.size()):
			goals[i] *= multiply_by
	
	if stop:
		return
	var en = energy
	energy = move_toward(energy, goals[index], speed)
	if energy == goals[index]:
		index += 1
	elif en > energy and energy < goals[index]:
		index+=1
	elif en < energy and energy > goals[index]:
		index += 1
		
	if index >= goals.size():
		index = 0
