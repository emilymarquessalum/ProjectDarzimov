extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var max_parries = 3
export var parry_timer = 1

var parry_clocks = []
var current_parry
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(max_parries):
			var timer = {'time_left': 0}
			parry_clocks.append(timer)
			
	pass # Replace with function body.

signal attempted_parry
signal loaded()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if current_parry:
		current_parry['time_left'] -= delta
		if current_parry['time_left'] <= 0:
			current_parry['time_left'] = 0
			current_parry = _find_unloaded_parry()
			if not current_parry:
				emit_signal("loaded")	

	if Input.is_action_just_pressed("parry"):
		emit_signal("attempted_parry")
		if not _can_parry():
			return
		if Game.Player.do_action("Parry"):
			_expend_parry()
			$ParryColider.disabled = false
			Game.Player.connect("finished_animation", self, "_finish_parry",[],CONNECT_ONESHOT)
			
		
func _find_unloaded_parry():
	var timers = parry_clocks.duplicate()

	for timer in timers:
		if timer["time_left"] != 0:
			return timer

func _can_parry():
	var timers = parry_clocks.duplicate()
	timers.invert()
	for timer in timers:
		if timer["time_left"] == 0:
			return true
	
	return false

signal used_parry()
func _expend_parry():
	var timers = parry_clocks.duplicate()
	timers.invert()
	
	var tim = parry_timer
	
	for timer in timers:
		if timer["time_left"] == 0:
			current_parry = timer
			timer["time_left"] = tim
			emit_signal("used_parry")
			break
		else:
			tim = timer["time_left"]
			timer["time_left"] = parry_timer
			

func _finish_parry():
	$ParryColider.disabled = true
	Game.Player.end_action()
