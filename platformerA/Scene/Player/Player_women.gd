extends KinematicBody2D

var state
var input

var Player_health = 100
var is_attacked = false

var velocity = Vector2()
const Jump = -10000
var OnGround = false
var is_attacking = false
var moving = true

export var Run = 140
export var _push_back = 80

const GRAVITY = 300
const FLOOR = Vector2(0, -1)

var isLife = true
var move = false

var _boss
var values = 0.25

var _ouch = false

enum States {
	IDLE,
	RUN,
	JUMP,
	FALL,
	DIE,
	HURT,
#	DASH,
	OUCH,
	ATTACK
}

func _ready():
	moving = false
	Playermanager.player = self
	state = States.IDLE
	$Anna.flip_h = false
	is_attacked = false
	isLife = true
	if Playermanager.boss_battle == true:
		_boss = get_parent().get_node("FireDemon")
	_ouch = false
	
func _physics_process(delta):
	match state:
		States.IDLE:
			_idle(delta)
		States.RUN:
			_Run(delta)
		States.JUMP:
			_Jump(delta)
		States.OUCH:
			ouch()
#		States.DASH:
#			_dash()
		States.ATTACK:
			_attack(delta)
		States.HURT:
			_hurt(0.75)
		States.DIE:
			_die()

func _idle(delta):
	update_input()
	if input.move_right or input.move_left and is_attacked == false and isLife == true:
		_Run(delta)
		if input.attack:
			_attack(delta)
			velocity.x = 0
	elif input.move_up and OnGround  and is_attacked == false and isLife == true:
		_Jump(delta)
#	elif input.dash and isLife == true and velocity.x != 0:
#		_dash()
	elif input.attack and is_attacked == false and isLife == true:
		if velocity.x == 0:
			_attack(delta)
	elif is_attacked == true: 
		if isLife == true:
			_hurt(0.75)
		elif isLife == false:
			_die()
	else:
		if is_attacked == true:
			_hurt(0.75)
			is_attacked = false
		if is_attacked == false and isLife == true:
			if OnGround:
				$AnimationPlayer.play("Idle")
				velocity.x = 0
			
	movement(delta)
	
func _Run(delta):
	update_input()
	move = true
	if input.move_right and move == true:
		velocity.x = Run
		$AnimationPlayer.play("Run")
		$Anna.flip_h = false
		$HitPosition.scale.x = 1
			
	elif input.move_left and move == true:
		velocity.x = -Run
		$AnimationPlayer.play("Run")
		$Anna.flip_h = true
		$HitPosition.scale.x = -1
		
	if input.attack:
		_attack(delta)
		velocity.x = 0
		
	if input.move_up and OnGround:
		_Jump(delta)
	
#	if input.dash:
#		_dash()
	
	if is_attacked == true:
		_hurt(0.75)
		is_attacked = false
		move = false
	
	if isLife == false:
		_die()
		isLife = true
	
func _Jump(delta):
	update_input()
	if OnGround:
		velocity.y = Jump * delta
		OnGround = false
		is_attacking = false

#	if input.dash:
#		_dash()
	
	if is_attacked == true:
		_hurt(0.75)
		is_attacked = false
		
	if isLife == false:
		_die()
		isLife = true
		
#func _dash():
#	update_input()
#	print("dash")
#	CanDash = true
#	if input.move_right:
#		DashDirection = Vector2(1,0)
#	elif input.move_left:
#		DashDirection = Vector2(-1,0)
#
#	if input.dash and CanDash == true:
#		velocity = DashDirection.normalized() * 2000
#		CanDash = false
#		Dashing = true
#		yield(get_tree().create_timer(0.2), "timeout")
#		velocity.x = lerp(velocity.x,0,0.5)
#		Dashing = false
		

	
func _attack(_delta):
#	update_input()
	is_attacking = true
	OnGround = true
	move = false
	if input.attack and is_attacking == true and move == false:
		$AnimationPlayer.play("Attack_1")
		$Timer_attack.start()
		
		if input.move_right or input.move_left and move == true:
			_Run(_delta)
		
	if is_attacked == true:
		_hurt(0.75)
		is_attacked = false

func _hurt(value):
	is_attacked = true
	if is_attacked == true:
		if _ouch == false:
			Player_health -= 25 * value
		else:
			Player_health -= 0.5 * value
			_ouch = false
		Playermanager.gui.set_bar_value(Player_health)
		is_attacked = false
		if Player_health <= 0:
			_die()
			Run = 0
		
func ouch():
	velocity.y = -300 * values
	if position.x <= _boss.position.x:
		velocity.x = -_push_back
	
	elif position.x >= _boss.position.x:
		velocity.x = _push_back
	
	
	_ouch = true
	_hurt(values)
	

func _die():
	isLife = false
	if isLife == false:
		$AnimationPlayer.play("Die")
		velocity = Vector2.ZERO
		$Timer.start()

func movement(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		OnGround = true
	else:
		OnGround = false
		if velocity.y < 0:
			$AnimationPlayer.play("Jump")
		if velocity.y > 0:
			$AnimationPlayer.play("Air")
			
	velocity = move_and_slide(velocity,FLOOR)


func update_input():
	input = {
		move_left = Input.is_action_pressed("MoveLeft"),
		move_right = Input.is_action_pressed("MoveRight"),
		move_up = Input.is_action_pressed("MoveUp"),
		attack = Input.is_action_pressed("attack")
	}


func _on_HitBox_body_entered(body):
	if body.name == "enemy2":
		body.Damage()
	elif body.name == "enemy3":
		body.Damage()
		
	if body.name == "FireDemon":
		_boss._hurt()


func _on_Timer_timeout():
	print("ahh")
	Playermanager.boss_battle = false
	var _change_scene
	_change_scene = get_tree().change_scene("res://Scene/level/world1.tscn")


func _on_Area2D_body_entered(_body):
	velocity = Vector2.ZERO
	
func _on_Timer_attack_timeout():
	move = true


func _on_CanvasLayer_transitioned():
	$CanvasLayer.queue_free()
