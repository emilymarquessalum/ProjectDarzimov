extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	attack = bow.attack.new()
	attack._set_controller (find_parent("shadow_form"))
	attack.target_groups = ["Player", "Player Arrow"]
	attack.arrow_groups = ["Enemy Arrow"]
	

var p_sub_index =  0
var attack
var bow = Items.bow


var interval = 60
var frames = 0
@onready var p = find_parent("shadow_form") 
func _update(s):
	p._look_at(p.player.position, true)
	frames += 1
	interval = p.patterns[p.p_index].pattern[p_sub_index]
		
	if frames > interval:
		attack.do_action()
		frames = 0
		p_sub_index += 1
		if p_sub_index >= p.patterns[p.p_index].pattern.size():
			p_sub_index = 0
			p.p_index += 1
			if p.p_index >= p.patterns.size():
				p.p_index = 0
				p._change_state(0,"running")
				return
			p._change_state(0,"prepare_attack")
			
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
