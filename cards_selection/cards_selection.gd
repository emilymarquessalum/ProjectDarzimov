extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var selected_card
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@onready var card_ui = load("res://cards/card_ui.tscn")
func _open():
	for card in CardsData.cards_acquired:
		var new_card_ui = card_ui.new()
		new_card_ui.change_card(card)
		$Grid/GridContainer.add_child(new_card_ui)
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
