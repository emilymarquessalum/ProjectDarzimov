extends Enemy


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_change_state("unactive")
	pass # Replace with function body.

func _mimic_start():
	_change_state("attacking")
	
	
	
var override = false
func _physics_process(delta):
	velocity.y += 1000*delta
	
	current_state._state_behaviour(delta)
	
	
	if override:
		override = false
		return
	var current_snap = Vector2.DOWN  * 5
	
	
	
	velocity = move_and_slide_with_snap(velocity, current_snap
	
	, Vector2.UP)
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
