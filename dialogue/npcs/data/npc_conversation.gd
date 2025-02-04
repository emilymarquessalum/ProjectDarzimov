extends Resource
class_name npc_conversation


@export var index: int

@export var npc_script: Resource

@export var npc_data: Resource
# will be used to find path inside a folder of characters,
# so their sprites can be used in dialogue
@export var character_1: String
@export var character_2: String


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
