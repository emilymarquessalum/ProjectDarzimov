extends Control

onready var cards = [$Card1, $Card2, $Card3]

var cards_d = cards_data.new()

func _ready():
	change_cards(CardsData.cards_d,false)

func change_cards(new_cards, inicialize_effects = true):
	for i in range(new_cards.size()):
		cards[i]._change_card(new_cards[i], inicialize_effects)
		CardsData.cards_d[i] = new_cards[i]
		
func change_card(new_card, index=0):
	cards[index]._change_card(new_card)
	CardsData.cards_d[index] = new_card
