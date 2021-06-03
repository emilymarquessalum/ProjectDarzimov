extends Node2D
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var detection_range
export(int) var health
export(Resource) var sprite
export(float) var size
export(Color) var tone_modification
# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerDetector/Colider.shape.radius = detection_range
	$Sprite.texture = sprite
	$Sprite.modulate = tone_modification
	$Sprite.scale = Vector2(size,size)
	$Health.max_health = health
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.editor_hint:
		$PlayerDetector/Colider.shape.radius = detection_range
		$Sprite.texture = sprite
		$Sprite.modulate = tone_modification
		$Sprite.scale = Vector2(size,size)
