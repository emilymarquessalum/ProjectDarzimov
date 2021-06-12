extends Control

onready var inventory = $Inventory
onready var cards = $Cards
var opened = false

signal closed_interface()
signal opened_interface()

func _ready():
	visible = false

# Fecha tudo!
func _close_all():
	inventory.visible = false
	inventory._close_inventory()

# Abrir inventário!
func _on_equipment_button_pressed():
	_close_all()	
	inventory.visible = true
	inventory._open_inventory()

# Abrir cartas!

# Vai abrir configurações eventualmente!
func _on_configurations_button_pressed():
	_close_all()

# Volta ao menu principal!
func _on_exit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://menu/menu.tscn")

func _process(delta):
	if Input.is_action_just_released("open_interface"):
		if not opened:
			_open_interface()
		else:
			_close_interface()

func _open_interface():
	opened = true
	visible = true
	get_tree().paused = true
	emit_signal("opened_interface")
	inventory._open_inventory()
	inventory.visible = true
	get_tree().get_current_scene().find_node("lighting").visible = false

func _close_interface(d=null):
	if not opened:
		return
	opened = false
	visible = false
	get_tree().paused = false
	emit_signal("closed_interface")
	_close_all()
	get_tree().get_current_scene().find_node("lighting").visible = true
