extends AnimatedSprite


func _taken_damage(c):
	blink = true
	
func _normal_state():
	blink = false
	get_parent().visible = true

var blink = false
var blink_frames = 0
func _process(delta):
	if blink:
		
		blink_frames += 1
		if blink_frames >= 5:
			get_parent().visible = !get_parent().visible
			blink_frames = 0
