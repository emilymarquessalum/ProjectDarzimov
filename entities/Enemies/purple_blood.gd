extends GPUParticles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var enemy 
var frames=0
func _update(en):
	enemy = en
	
	frames += 1
	if frames <30:
		return
	frames = 0
	var collision = en.move_and_collide(Vector2.ZERO,true,true,true)
	if not (collision and collision.collider is TileMap):
		return
	var tilemap = collision.collider
	
	var pos = tilemap.local_to_map(tilemap.to_local(en.global_position))
	pos -= collision.normal
	
	var id = tilemap.get_cellv(pos)
	if id == 0:
		tilemap.set_cell(pos.x, pos.y, 1)
	
func _on_Timer_timeout():
	enemy.behaviours.erase(self)
	one_shot = true
	pass # Replace with function body.
