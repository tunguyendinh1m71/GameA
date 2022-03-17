#extends KinematicBody2D
#
#
#var velocity = Vector2()
#
#const MAX_SPEED = 130
#const JUMP_POWER = -260
#const GRAVITY = 10
#
#
#var isAttacking = false
#var AttackPoints = 3
#var Attack_stats = 10
#
#var on_ground = false
#
#var dead = false
#func _ready():
#	dead = false
#	on_ground = true
#	$Sam.play("idle")
#
## warning-ignore:unused_argument
#func _physics_process(delta):
#	MOVEMENT()
#	JUMP()
#	ATTACK()
#	velocity.x = lerp(velocity.x,0,0.2)
#	velocity = move_and_slide(velocity, Vector2.UP)
#
#
#func MOVEMENT():
#	if dead == false:
#		if Input.is_action_pressed("MoveLeft"):
#			velocity.x = -MAX_SPEED
#			$Sam.play("run")
#			$Sam.flip_h = true
#			if Input.is_action_pressed("jump"):
#				$Sam.play("jump")
#		elif Input.is_action_pressed("MoveRight"):
#			velocity.x = MAX_SPEED
#			$Sam.play("run")
#			$Sam.flip_h = false
#			if Input.is_action_pressed("jump"):
#				$Sam.play("jump")
#		else:
#			velocity.x = 0
#			if isAttacking == false:
#				$Sam.play("idle")
#				if Input.is_action_pressed("jump"):
#					$Sam.play("jump")
#				if not is_on_floor():
#					if velocity.y < 0:
#						$Sam.play("jump")
#					else:
#						$Sam.play("air")
#		velocity.y += GRAVITY
#
#func JUMP():
#		if is_on_floor():
#			on_ground = true
#			if Input.is_action_pressed("jump"):
#				if on_ground == true:
#					velocity.y = JUMP_POWER
#					on_ground = false
#			if Input.is_action_just_released("jump"):
#				if on_ground == false:
#					$Sam.play("air")
#
#func ATTACK():
#		if Input.is_action_pressed("attack"):
#			$StaminaDisplay/StaminaBar.value -= 1
#			if $StaminaDisplay/StaminaBar.value == 0:
#				$HealthDisplay/HealthBar.value -= 0.1
#
#		if Input.is_action_just_pressed("attack") and AttackPoints == 3:
#			$AttackResetTime.start()
#			$Sam.play("slash3")
#			if $Sam.flip_h == false:
#				$AttackArea_right/CollisionShape2D.disabled = false
#			else:
#				$AttackArea_left/CollisionShape2D.disabled = false
#			isAttacking = true
#			AttackPoints -= 1
#
#		elif Input.is_action_just_pressed("attack") and AttackPoints == 2:
#			$AttackResetTime.start()
#			$Sam.play("slash2")
#			if $Sam.flip_h == false:
#				$AttackArea_right/CollisionShape2D.disabled = false
#			else:
#				$AttackArea_left/CollisionShape2D.disabled = false
#			isAttacking = true
#			AttackPoints -= 1
#
#		elif Input.is_action_just_pressed("attack") and AttackPoints == 1:
#			$AttackResetTime.start()
#			$Sam.play("slash1")
#			if $Sam.flip_h == false:
#				$AttackArea_right/CollisionShape2D.disabled = false
#			else:
#				$AttackArea_left/CollisionShape2D.disabled = false
#			isAttacking = true
#			AttackPoints = AttackPoints - 1
#
#func FrameFreeze(timescale,duration):
#	Engine.time_scale = timescale
#	yield(get_tree().create_timer(duration * timescale), "timeout")
#	Engine.time_scale = 1.0
#
#func damage():
#	$HealthDisplay/HealthBar.value -= 10
#	$Sam.play("Hurt")
#	if $HealthDisplay/HealthBar.value == 0:
#		dead = true
#		velocity = Vector2.ZERO
#		$Sam.play("dead")
#		$CollisionShape2D.disabled = true
#		$Time_after_dead.start()
#
#func _on_Sam_animation_finished():
#	if $Sam.animation == "slash1" || $Sam.animation == "slash2" || $Sam.animation == "slash3":
#		if $Sam.flip_h == false:
#			$AttackArea_right/CollisionShape2D.disabled = true
#		else:
#			$AttackArea_left/CollisionShape2D.disabled = true
#		isAttacking = false
#
#
#
#
#func _on_AttackResetTime_timeout():
#	AttackPoints = 3
#
#
#func _on_Time_after_dead_timeout():
## warning-ignore:return_value_discarded
#	get_tree().change_scene("res://level/world1.tscn")
#
#func _on_AttackArea_right_body_entered(body):
#	if Attack_stats == 10:
#		body.enemy_dead_1()
#
#
#func _on_AttackArea_left_body_entered(body):
#	if Attack_stats == 10:
#		body.enemy_dead_1()
