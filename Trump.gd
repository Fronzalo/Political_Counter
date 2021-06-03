extends KinematicBody2D
var speed = 150
var velocity 
onready var player = get_parent().get_node("Player")
var move = true
var side
var s 
var target = Vector2.ZERO
var behaviour
var movex 
var movey
var attacking
onready var missles_shot = 0
var fire_missile = false
onready var max_missiles = 0
onready var tmissile = preload("res://trump_missile.tscn")
func _physics_process(delta):
#	velocity = position.direction_to(player.position) * speed
#	velocity = target * speed

	if move == true:
		if behaviour == 1:
			target = player.position
			#velocity = target * speed
			position = position.move_toward(target,delta * speed)

		if behaviour == 2:
			target.y = player.position.y
			target.x = position.x
			position = position.move_toward(target,delta*speed)
			if position.y == player.position.y:
				lazer()
				$Pause.start()
			
		if behaviour == 3:
			#attacking == true
			$Attack_Timer.wait_time = rand_range(2,4)
			$Attack_Timer.start()
			if attacking == false:
				missile()
			else:
				target = Vector2(movex, movey).normalized()
				move_and_slide(target * speed)

		else:
			pass
	else:
		pass

func missile():
	attacking = true 
	behaviour = 0
	$Go.stop()
	$Pause.stop()
	$Walk.hide()
	$Missile.show()
	$AnimationPlayer.play("missile open")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("missile")
	max_missiles = round(rand_range(5,9))
	$missle_timer.start()

func missileshoot():
	var e = tmissile.instance()
	get_parent().add_child(e)
	e.transform = $Missile_Position.global_transform
	e.position.x += (rand_range(-10,10))
	
	missles_shot += 1
 
func lazer():
	attacking = true
	$Go.stop()
	move = false
	behaviour = 0
	target.x = position.x
	target.y = position.y
	$Walk.hide()
	$Lazer.show()
	$AnimationPlayer.play("lazer open")
	yield($AnimationPlayer,"animation_finished")
	$Attack_Timer.wait_time = 4
	$Attack_Timer.start()
	if attacking == true:
		$AnimationPlayer.play("lazer")
		$Lazer_Position.show()
		$Lazer_Position/Lazer/RayCast2D.set_enabled(true)
	else: 
		print("IVE STOPPED FIRING MY LAZER BEAM")
		$Lazer_Position.hide()
		$Lazer_Position/Lazer/RayCast2D.set_enabled(false)
		$AnimationPlayer.play("lazer close")
		yield($AnimationPlayer,"animation_finished")
		$Lazer.hide()
		$Idle.show()
		$AnimationPlayer.play("Idle")
		$Pause.start()

func _on_Go_timeout():
	move = true
	print("go")
	$Pause.wait_time = rand_range(3,6)
	behaviour = round(rand_range(1,3))
	print(behaviour)
	$Pause.start()
	$Idle.hide()
	$Walk.show()
	$AnimationPlayer.play("Walk")
	movex = rand_range(-400, 400)
	movey = rand_range(-200, 200)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if side == "Left":
			PlayerInfo.change_health(-1)
		else:
			PlayerInfo.change_health(+1)

func _on_Pause_timeout():
	move = false
	print("pause")
	$Go.wait_time = rand_range(3,6)
	$Go.start()
	$Idle.show()
	$Missile.hide()
	$Walk.hide()
	$Lazer.hide()
	$AnimationPlayer.play("Idle")

func _on_Attack_Timer_timeout():
	attacking = false


func _on_missle_timer_timeout():
	if missles_shot <= max_missiles:
		missileshoot()
			#this code dosent work yet...
	else:
		print("IVE STOPPED FIRING MY MISSILES")
		$AnimationPlayer.play("missle close")
		yield($AnimationPlayer,"animation_finished")
		$Missile.hide()
		$Pause.start()
		$Idle.show()
		missles_shot = 0
		$missle_timer.stop()

