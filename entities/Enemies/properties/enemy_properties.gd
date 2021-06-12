extends Node2D
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var y_start_perception = 20
export(int) var health


export(Dictionary) var properties = {
	"sprite":{'position' : Vector2(0,0),
	'scale' : Vector2(1,1), 'sprite' : "add image", 
	'tone' : Color.white},
	
	"middle_shape":{'position' : Vector2(0,0),
	'scale' : Vector2(1,1)},
	
	"below_ground_detector":{'position' : Vector2(-3,3),
	'direction' : Vector2(0,15)},
	
	
	"front_ground_detector":{'position' : Vector2(-9,3),
	'direction' : Vector2(0,15)},
	
	"detection_radius":{'radius' : 60},
	

}

# Called when the node enters the scene tree for the first time.
func _ready():
	_update_properties()
	$Health.health = health
	$Health.max_health = health
	pass # Replace with function body.

func _update_properties():
	for p in properties.keys():
		var pd = find_node(p)
		pd.update_property(properties[p])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.editor_hint:
		_update_properties()
		#$middle_area/CollisionShape2D.scale = Vector2(size_x,size_y)	
	
