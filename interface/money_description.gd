extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var money = get_tree().get_current_scene().get_node("Player/Money")
	money.connect("money_changed", self, "change_interface")
	pass # Replace with function body.
	change_interface(money.money)

func change_interface(money):
	text = "money:" + str(money)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
