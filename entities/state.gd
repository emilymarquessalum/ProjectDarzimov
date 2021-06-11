extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	for s in used_behaviours:
		behaviours.append(behaviour.get_node(s))

onready var behaviour  = get_parent().get_parent().find_node("behaviours")
export(Array,String) var used_behaviours = []
onready var behaviours = []
func _state_behaviour(delta):
	for b in behaviours:
		b._update(delta, get_parent().get_parent())

func _start_state():
	for b in behaviours:
		b._start_behaviour()
		
		
export(String) var state_name = "not named"
func get_name():
	return state_name
	
