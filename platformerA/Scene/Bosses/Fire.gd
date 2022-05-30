extends KinematicBody2D

var move = Vector2(40,0)
var velocity = Vector2.ZERO
const Gravity = 4000
var Floor = Vector2.UP
var direction = Vector2()


var player

var damage = true
var dead = false

var stat_machine

var heatlh

func _ready():
	init_node()
	damage = true
	dead = false
	heatlh.value = 100
	
func init_node():
	player = get_parent().get_node("Player2")
	stat_machine = $AnimationTree.get("parameters/playback")
	heatlh = get_parent().get_node("FireDemon/Boss_health/CanvasLayer/TextureProgress")
	
func _physics_process(delta):
	
	manage_animation()
	get_direction()
	velocity = calculate_velocity(direction,velocity,delta)
	velocity = move_and_slide(velocity,Floor)
	
	
func get_direction():
	if !is_in_range() and !is_on_range():
		if player.get_node("CollisionShape2D").global_position.x < $CollisionShape2D.global_position.x :
			direction.x = -1

		elif player.get_node("CollisionShape2D").global_position.x > $CollisionShape2D.global_position.x:
			direction.x = 1
			
		if player.get_node("CollisionShape2D").global_position.y < $CollisionShape2D.global_position.y:
#			if player.get_node("CollisionShape2D").global_position.x == $CollisionShape2D.global_position.x:
				direction.x = 0
				print(direction.x)
				stat_machine.travel("Idle")
				
	else:
		direction.x = 0
		
			
func manage_animation():
	if dead == false:
		if !is_in_range() and (!is_on_range()) and is_on_floor():
			if direction.x == -1:
				stat_machine.travel("Move_left")
			elif direction.x == 1:
				stat_machine.travel("Move_right")
				
				
		else:
			stat_machine.travel("Attack")
			
	else:
		stat_machine.travel("Death")
		

func calculate_velocity(dir, vel, delta):
	var _new_vel = vel
	
	if !is_on_floor():
		_new_vel.y += Gravity * delta
		
	if is_on_floor():
		_new_vel.x = dir.x * move.x
		
	if direction.x == 0:
		_new_vel.x = 0
		
	if dead == true:
		_new_vel = Vector2.ZERO
		
	return _new_vel

func _die():
	queue_free()
	
func _hurt():
	heatlh.value -= 10
	if heatlh.value == 0:
		Playermanager.close_game = true
		dead = true
	
func Damage():
	if is_in_range():
		player._hurt(0.9)
	
func is_in_range() -> bool:
	var in_range
	var OLbodies
	if dead == false:
		OLbodies = $Attack_detect.get_overlapping_bodies()
	else:
		return OLbodies
	
	for body in OLbodies:
		if body.name == player.name:
			in_range = true
			break
		else:
			in_range = false
	
	return in_range
	
func is_on_range() -> bool:
	var _bodies
	var _on_range
	if dead == false:
		_bodies = $Collision_detect.get_overlapping_bodies()
	else:
		return _bodies
	
	for body in _bodies:
		if body.name == player.name:
			_on_range = true
			if _on_range == true:
				player.ouch()
			break
		else:
			_on_range = false
	
	return _on_range
	
