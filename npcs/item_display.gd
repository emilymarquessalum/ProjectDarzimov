extends Control


func _change_image(new_image):
	$image.texture = new_image

var x_limit = 50
var y_limit = 50
var grow_speed = 0.5
var finished_animation = false
signal finished_animation()

func _process(delta):
	if finished_animation:
		return
		
	var moved = false
	
	if x_limit > $image.rect_size.x:
		$image.rect_size.x +=  grow_speed
		$image.rect_position.x -=  grow_speed*0.5
		moved = true
	if y_limit > $image.rect_size.y:
		$image.rect_size.y +=grow_speed
		$image.rect_position.y -=  grow_speed*0.5
		moved = true
		
	if not moved:
		finished_animation = true
		emit_signal("finished_animation")
