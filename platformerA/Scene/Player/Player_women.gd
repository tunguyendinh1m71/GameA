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
export (int) var Acceleration: int = 30
export (int) var Friction: int = 50

const GRAVITY = 320
const FLOOR = Vector2(0, -1)

var isLife = true

enum States {
	IDLE,
	RUN,
	JUMP,
	FALL,
	DIE,
	HURT,
	ATTACK,
	RUN_ATTACK
}

func _ready():
	Playermanager.player = self
	state = States.IDLE
	$Anna.flip_h = false
	is_attacked = false
	isLife = true
	
func _physics_process(delta):
	match state:
		States.IDLE:
			_idle(delta)
		States.RUN:
			_Run(delta)
		States.JUMP:
			_Jump(delta)
		States.ATTACK:
			_attack()
		States.RUN_ATTACK:
			_run_attack()
		States.HURT:
			_hurt(0.75)
		States.DIE:
			_die()

func _idle(delta):
	update_input()
	if input.move_right or input.move_left and is_attacked == false  and isLife == true:
		_Run(delta)
	elif input.move_up and OnGround  and is_attacked == false and isLife == true:
		_Jump(delta)
	elif input.attack and is_attacked == false and isLife == true:
		if velocity.x == 0:
			_attack()
		elif velocity.x != 0:
			_run_attack()
	elif is_attacked == true: 
		if isLife == true:
			_hurt(0.75)
		elif isLife == false:
			_die()
	else:
		moving = false
		if is_attacked == true:
			_hurt(0.75)
			is_attacked = false
		if is_attacked == false and isLife == true and moving == false:
			velocity.x = 0
			if OnGround:
				$AnimationPlayer.play("Idle")
			
	movement(delta)
	
func _Run(delta):
	update_input()
	if input.move_right:
		velocity.x = Run
		$AnimationPlayer.play("Run")
		$Anna.flip_h = false
		$HitPosition.scale.x = 1
			
	elif input.move_left:
		velocity.x = -Run
		$AnimationPlayer.play("Run")
		$Anna.flip_h = true
		$HitPosition.scale.x = -1
		
	if input.attack:
		_run_attack()
		moving = false
		
	if input.move_up and OnGround:
		_Jump(delta)
		
	
	if is_attacked == true:
		_hurt(0.75)
		is_attacked = false
	
	if isLife == false:
		_die()
		isLife = true
	
func _Jump(delta):
	update_input()
	if OnGround:
		velocity.y = Jump * delta
		OnGround = false
		is_attacking = false
		moving = true
	
	if is_attacked == true:
		_hurt(0.75)
		is_attacked = false
		
	if isLife == false:
		_die()
		isLife = true

	
func _attack():
	update_input()
	is_attacking = true
	OnGround = true
	moving = false
	if input.attack and is_attacking == true and OnGround == true and moving == false:
		if velocity.x == 0:
			$AnimationPlayer.play("Attack_1")
#			is_attacking = false
		elif velocity.x != 0:
			_run_attack()
			
	if is_attacked == true:
		_hurt(0.75)
		is_attacked = false

func _run_attack():
	update_input()
	is_attacking = true
	OnGround = true
	moving = true
	if input.attack and is_attacking == true and OnGround == true and moving == true:
		$AnimationPlayer.play("Run_attack")
		
		$Timer2.start()
		
	if is_attacked == true:
		_hurt(0.75)
		is_attacked = false

func _hurt(value):
	is_attacked = true
	if is_attacked == true:
		Player_health -= 25 * value
		Playermanager.gui.set_bar_value(Player_health)
		is_attacked = false
		if Player_health <= 0:
			_die()
			Run = 0
	
func _die():
	isLife = false
	if isLife == false:
		$AnimationPlayer.play("Die")
		velocity = Vector2.ZERO
		print("ahhh")
		$Timer.start()

func movement(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		OnGround = true
		moving = true
	else:
		OnGround = false
		moving = true
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
	
	
func _on_Timer_timeout():
	var _change_scene
	_change_scene = get_tree().change_scene("res://Scene/level/world1.tscn")



func _on_Timer2_timeout():
	print("bubobuo")
	$AnimationPlayer.play("Idle")
	velocity.x = 0
