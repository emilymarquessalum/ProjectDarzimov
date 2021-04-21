extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var money = 100
signal money_changed(money)



func add_to_money(value):
	money += value
	emit_signal("money_changed", money)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
