extends KinematicBody2D

var velocity = Vector2(0,0)
var gravity = 320
var FLOOR = Vector2(0,-1)

var hurt = false

var walk = 40
var is_moving_right = true

var HP = 20

func _ready():
	Playermanager.enemy1 = self
	$AnimationPlayer.play("idle")
	is_moving_right = true
	hurt = false
	
func _physics_process(delta):
	if $AnimationPlayer.current_animation == "Attack":
		return
	
	movement(delta)
	detect_turn_around()
	
	
func movement(delta):
#	velocity.x = walk if is_moving_right else -walk
	if is_moving_right == true and hurt == false:
		velocity.x = walk
	elif is_moving_right == false and hurt == false:
		 velocity.x = -walk
		
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, FLOOR)

func detect_turn_around():
	if $RayCast2D.is_colliding() and is_on_wall() and hurt == false:
		is_moving_right = !is_moving_right
		scale.x= -scale.x
	
	if not $RayCast2D.is_colliding() and is_on_floor() and hurt == false:
		is_moving_right = !is_moving_right
		scale.x= -scale.x
		
func Damage():
	hurt = true
	if hurt == true:
		HP -= 9
#		Playermanager.gui_1A.reset_new_health(HP)
		print("ouchha")
		hurt = false
		if HP <= 0:
			walk = 0
			_Die()
		
func _Die():
	$AnimationPlayer.play("Die")
	$After_die.start()

func _on_PlayerReact_body_entered(_body):
	$AnimationPlayer.play("Attack")
	$End_Attack.start()

func _on_Attacked_detector_body_entered(body):
	body._hurt(0.75)


func _on_End_Attack_timeout():
	$AnimationPlayer.play("idle")


func _on_After_die_timeout():
	queue_free()
