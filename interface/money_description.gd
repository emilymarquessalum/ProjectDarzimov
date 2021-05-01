extends Label

func _ready():
	var money = get_tree().get_current_scene().get_node("Player/Money")
	money.connect("money_changed", self, "change_interface")
	pass
	change_interface(money.money)

func change_interface(money):
	text = "money:" + str(money)
