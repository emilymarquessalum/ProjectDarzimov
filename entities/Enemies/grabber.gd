extends Area2D

var grab_time = 0
var warning_text
onready var player = get_tree().get_current_scene().find_node("Player")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	warning_text = Label.new()
	warning_text.text = "click x to be released!"
	warning_text.rect_position = Vector2(100,100)
	
func _process(delta):
	if player.current_state.state_name == "grabbed":
		return
	if overlaps_body(player):
		get_tree().get_current_scene().add_child(warning_text)
		player._change_state("grabbed", {'release_clicks': 8, 'grabber': self})
	
func _end_grab():
	get_tree().get_current_scene().remove_child(warning_text)
	grab_time = 0
	player.velocity.y -= 300
	#remove()
	
func remove():
	get_parent().remove_child(self)
	


func _eat_player():
	get_tree().get_current_scene().remove_child(warning_text)

func _grab_update():
	grab_time += 1
	
	if grab_time > 120:
		grab_time = 0
		player.health_control._take_damage(1)
		if player.health_control._get_health() == 0:
			_eat_player()
