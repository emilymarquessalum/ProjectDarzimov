extends Entity
class_name Enemy

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var ranking = 1
var health = 3


func _die():
	queue_free()

func take_damage(damage):
	health -= damage
	if health <= 0:
		_die()

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
