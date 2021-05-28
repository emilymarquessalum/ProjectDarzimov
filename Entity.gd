extends KinematicBody2D
class_name Entity

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var keywords = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

signal added_keyword(keyword)
func _add_keyword(keyword):

	for k in keywords:
		if k.name == keyword.name:
			k.quantity += keyword.quantity
			emit_signal("added_keyword", k)
			return
	
	keywords.append(keyword)
	emit_signal("added_keyword", keyword)

	
signal removed_keyword(keyword)
func _remove_keyword(keyword):
	var k = null
	for i in range(keywords.size()):	
		if keywords[i].name == keyword.name:
			k = keywords[i]
			if k.quantity <= keyword.quantity:
				keywords.remove(i)
			else:
				k.quantity -= keyword.quantity
			break
	emit_signal("removed_keyword", k)


func keyword_number():
	return keywords.size()

func get_keyword(keyword_name):
	for keyword in keywords:
		if keyword.name == keyword_name:
			return keyword
	return null
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
