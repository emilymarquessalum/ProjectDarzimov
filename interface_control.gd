extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var inventory = $Inventory

onready var cards = $Cards
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func close_all():
	inventory.close_inventory()
	cards.visible = false

func _on_equipment_button_pressed():
	close_all()	
	inventory.open_inventory()
	
func _on_cards_button_pressed():
	close_all()
	cards.visible = true


func _on_configurations_button_pressed():
	close_all()

func _on_exit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://menu/menu.tscn")

var opened = false
signal closed_interface()

func open_interface():
	opened = true
	visible = true
	get_tree().paused = true
	
	inventory.open_inventory()
		
func close_interface(d=null):
	if not opened:
		return
	opened = false
	visible = false
	get_tree().paused = false
	emit_signal("closed_interface")
	close_all()

func _process(delta):
	if Input.is_action_just_released("open_interface"):
		if not opened:
			open_interface()
		else:
			close_interface()