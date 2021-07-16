extends Node
class_name cards_data


var cards = []
var justica = _make_card_data({'name': "justica",'sprite' : preload("res://Cursor.png"), 
'description': "Super arco.",
'behaviour' : preload("res://cards/card_items/justiça.gd").new()})

var cards_equipped	= [null,null,null]
var cards_acquired = []

func _make_card_data(data):
	cards.append(data)
	return data

func _ready():
	_equip_card(_get_card_data("justica"))

signal changed_cards_equipped()
func _equip_card(new_card, i = -1):
	 
	if i >= 0:
		cards_equipped[i].behaviour._end_behaviour(self)
		cards_equipped[i] = new_card
		new_card.behaviour._start_behaviour(self)
	else:
		for c in cards_equipped:
			i += 1
			if c == null:
				cards_equipped[i] = new_card
				new_card.behaviour._start_behaviour(self)
				break
	
	emit_signal("changed_cards_equipped")

func _get_card_data(name):
	for card in cards:
		if card["name"] == name:
			return card
	return null


func _acquire_card(name):
	var card = _get_card_data(name)
	if card == null:
		return
	card["acquired"] = true
	cards_acquired.append(card)

	
func _inic_run():
	for card in cards_equipped:
		card["behaviour"]._start_behaviour()
	
func _inic_data(save_data):
	var i = 0
	for card_name in save_data["cards_equipped"]:
		cards_equipped[i] = _get_card_data(card_name)
		i += 1
		
	for card_name in save_data["saved_cards"]:
		var card = _get_card_data(card_name)
		card["acquired"] = true
		cards_acquired.append(card)
func _save_data(current_save_data):
	var equipped_cards_name = []
	var cards_saved = []
	for card in cards_equipped:
		if card == null:
			continue
		var name = card["name"]
		equipped_cards_name.append(name)
		cards_saved.append(name)
		
	for card in cards_acquired:
		cards_saved.append(card["name"])
		
		current_save_data["saved_cards"] = cards_saved
		current_save_data["cards_equipped"] = equipped_cards_name
	return current_save_data
	
	
	
	
