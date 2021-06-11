extends Resource
class_name npc_conversation


export(int) var index

export(Resource) var npc_script

export(Resource) var npc_data
# will be used to find path inside a folder of characters,
# so their sprites can be used in dialogue
export(String) var character_1
export(String) var character_2


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
