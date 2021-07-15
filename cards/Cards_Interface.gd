extends Control

onready var cards = [$Card1, $Card2, $Card3]

var cards_d = cards_data.new()

func _ready():
	change_cards()
	CardsData.connect("changed_cards_equipped",self,"change_cards")

func change_cards():
	var new_cards = CardsData.cards_equipped
	for i in range(new_cards.size()):
		cards[i]._change_card(new_cards[i])
