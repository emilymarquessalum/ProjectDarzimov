extends tab_control


func _ready():
	tab_path = "res://tab_controls/npc_folder/shopper/shop.tscn"
	pass # Replace with function body.
var last_slot

func open_tab(itens: Array = items, i = null):
	.open_tab(itens)
	tab.get_node("buy").connect("pressed",self,"buy")
	
	var inv =get_tree().get_current_scene().get_node("Inventory")
	inv.connect("opened_inventory" ,self, "cancel_open")
	
	
	pass

func cancel_open():
	var inv =get_tree().get_current_scene().get_node("Inventory")
	inv.close_inventory()

func buy():
	if not last_slot or not last_slot.item:
		return
	var money = get_tree().get_current_scene().get_node("Player/Money")
	var item = last_slot.item
	var inv =get_tree().get_current_scene().get_node("Inventory")
	if money.money >= item.data.price:
		if inv.add_to_inventory(item.copy()):
			last_slot.take_item_from_slot()
			money.add_to_money(-item.data.price)
	last_slot.modulate = Color.white
	tab.get_node("description").bbcode_text = " "
	
	
func slot_attempt(slot,inv):
	if last_slot:
		last_slot.modulate = Color.white
	if slot.item == null:
		tab.get_node("description").bbcode_text = " "
		return 
	inv.cancel_slot_click = true
	slot.modulate = Color.yellow	
	last_slot = slot
	var it = slot.item.data
	tab.get_node("description").bbcode_text = it.item_name + ":" + "[color=yellow]" + str(it.price) + "[/color]"


func update():
	return