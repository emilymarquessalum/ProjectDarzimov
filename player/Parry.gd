extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var max_parries = 3
export var parry_timer = 1
var available_parries = 3

var parry_clocks = []
# Called when the node enters the scene tree for the first time.
func _ready():
	available_parries = max_parries
	for i in range(max_parries):
			var timer = Timer.new()
			add_child(timer)
			parry_clocks.append(timer)
			timer.connect("timeout", self, "change_parry_count", [1])
			timer.one_shot = true
	pass # Replace with function body.

onready var player = get_parent()
signal attempted_parry
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Input.is_action_just_pressed("parry"):
		emit_signal("attempted_parry")
		if available_parries <= 0:
			return
		if player.do_action("Parry"):
			expend_parry()
			$ParryColider.disabled = false
			player.connect("finished_animation", self, "finish_parry",[],CONNECT_ONESHOT)
			

func expend_parry():
	var timers = parry_clocks.duplicate()
	timers.invert()
	for timer in timers:
		if timer.is_stopped():
			timer.start(parry_timer)
			break
	
	change_parry_count(-1)
			
signal parry_count_updated()
func change_parry_count(v):
	emit_signal("parry_count_updated")
	available_parries += v

func finish_parry():
	$ParryColider.disabled = true
	player.end_action()
