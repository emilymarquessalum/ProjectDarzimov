extends behaviour


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var attack
func _ready():
	Global.connect("changed_weapon", self, "_update_attack")
func _update_attack(data):
	if data == null:
		attack = null
		return

	attack = data.attack.new()
	attack._set_controller(control)

func _start_behaviour():
	pass
	
	
func _update(delta, control):
	pass

func equipment_action():
	if attack == null:
		return
	attack.do_action()

func _process(delta):
	if Input.is_action_just_pressed("r"):
		equipment_action()
