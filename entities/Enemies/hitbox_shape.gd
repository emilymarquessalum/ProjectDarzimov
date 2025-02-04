extends property


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
@onready var en = get_parent().get_parent().get_parent()

func _on_hitbox_body_entered(body):
	_something_entered(body)

func _something_entered(body):
	if not body.is_in_group("Attack"):
		return	
	
	if body.has_target("Enemy"):
		en.health_control._take_damage(body.damage)


func _on_hitbox_area_entered(area):
	_something_entered(area)
