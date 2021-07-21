extends Entity

signal life_updated(life)
signal killed()

const GRAVITY = 15
const SPEED = 7000
const JUMP_FORCE = -17400


onready var invulnerability = $Invunerability
onready var anim = $AnimatedSprite
export var damage = 1
var velocity = Vector2.ZERO
var jump = 0
var jump_max = 2


func _ready():
	
	_change_state("normal")
	
	var spawn = get_tree().get_current_scene().get_spawn()
	
	spawn._fix_player_position(self)
	
	if Global.player_direction:
		flip = true
		scale.x = -scale.x
		
	$Health.connect("died", self, "_end_run")




var p
func _physics_process(delta):
	_test_for_enemy_col()
	_move(delta)
	
	current_state._state_behaviour(delta)
	
	if not has_done_action:
		anim.play("Idle")
	
	has_done_action = false

		
	

	
func _throw_off():
	pass
func _test_for_enemy_col():
	if _is_invulnerable():
		return false
	var en = move_and_collide(Vector2.ZERO,true,true,true)
	if en:
		en = en.collider
	
	if en and en.is_in_group("Enemy") and not p:
		
		if not en.deals_damage_on_touch:
			return false
		health_control._take_damage(1)
		
		if health_control.ignore_damage:
			return
		p = parabolic_movement.new()
		p._inic(self)
		p.tspeed = 1
		p.goal_reach = 5
		var d = en._get_direction()
		p._goal = Vector2((randi()%20+20)*d,0)+position
		p.connect("reached_goal",self,"tt")
		add_child(p)
		return true
	
func _move(delta):
	
	if p:
		p._update(delta)
		var col = move_and_collide(Vector2.ZERO,true,true,true)
		
		if col and col.collider is TileMap:
			tt()
		return
		
	velocity.y+= GRAVITY 
	velocity = move_and_slide(velocity, Vector2.UP)


func do_action(action):
	anim.play(action)
	$Anim.play(action)

signal finished_animation()
func _on_AnimatedSprite_animation_finished():
	emit_signal("finished_animation")


func _end_run():
	Global._reset()
	Game.game_off()
	var scen = load("res://interface/game_over.tscn").instance()
	get_tree().get_current_scene().find_node("CanvasLayer").add_child(scen)
	_change_state("dead")
	
func tt():
	
	remove_child(p)
	p = null

func _is_invulnerable():
	var inv = get_node("Invunerability")
	return inv.time_left != 0

