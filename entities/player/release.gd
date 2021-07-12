extends behaviour


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _start_behaviour_main(data):
	release_clicks = data["release_clicks"]
	grabber = data["grabber"]
	
var release_clicks = 0
var grabber
var released_frames = 0
func _update(delta, control):
	
	if release_clicks == 0:
		released_frames += 1
		
		if released_frames > 10:
			control._change_state("normal")
			released_frames = 0
		return	
	if Input.is_action_just_released("release"):
		release_clicks -= 1
		if release_clicks == 0:
			grabber._end_grab()
			return
	
	
	grabber._grab_update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
