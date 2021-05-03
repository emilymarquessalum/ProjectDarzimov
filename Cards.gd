extends Control

onready var cards = [$Card1, $Card2, $Card3]


func change_cards(new_cards):
	for i in range(new_cards.size()):
		cards[i]._change_card(new_cards[i])
		
		
func change_card(new_card, index=0):
	cards[index]._change_card(new_card)
