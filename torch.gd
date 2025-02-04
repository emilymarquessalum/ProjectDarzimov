@tool
extends PointLight2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

@export var goals = [] # (Array,float)
@export var speed: float = 0.1
@export var stop: bool = false
var index = 0

@export var multiply_by: float
@export var multiply: bool
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
