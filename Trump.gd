extends KinematicBody2D

						###  PRELOADS  AND OTHER IMPORTANT ON READY THINGS  ###						

onready var tmissile = preload("res://trump_missile.tscn")
onready var player = get_parent().get_node("Player")
onready var spawner = get_parent().get_node("Enemy_Spawner")


									###  VARIBLES   ###											


var speed = 150
var velocity 
var move = true
var s 
var size
var target = Vector2.ZERO
var behaviour
var movex 
var movey
var attacking
onready var missles_shot = 0
var fire_missile = false
onready var max_missiles = 0
var health = 20
onready var misslepos = $Missile_Position.position.x
onready var lazerpos = $Lazer_Position.position.x
var side = "right"
 
									###     BEHAVIOUR CODE     ###							


func get_side():
	return(side)

func _ready():
	add_to_group("enemies")
	size = get_viewport().get_visible_rect().size

func flip(face):
	$Trump.flip_h = face
	$Idle.flip_h = face
	$Walk.flip_h = face
	$Missile.flip_h = face
	$Lazer.flip_h = face
	if face == true:
		$Missile_Position.position.x = -misslepos
		$Lazer_Position.position.x = -lazerpos/3
		$Lazer_Position/Lazer.position.x = -lazerpos
		$Lazer_Position.scale.x = -1
	else:
		$Missile_Position.position.x = misslepos
		$Lazer_Position.position.x = lazerpos/3
		$Lazer_Position/Lazer.position.x = lazerpos
		$Lazer_Position.scale.x = 1



func _physics_process(delta):

	if position.x > player.position.x:
		flip(true)
	else:
		flip(false)


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
			else: #makes trump not press against the wall
				if movey <= global_position.y - movey or movey >= size.y + movey:
					movey = clamp(movey, 50, size.y-50)
				if movex <= global_position.x - movex or movex >= size.x + movex:
					movex = clamp(movex, 100, size.x-100)
				target = Vector2(movex, movey).normalized()
				move_and_slide(target * speed)

		else:
			pass

	else:
		pass
	
	if health <= 0 and health >= -5:
		health = -10
	if health == -10:
		explode()
		health = -9



func explode():
	speed = 0
	$Go.stop()
	$Pause.stop()
	$Lazer.hide()
	$missle_timer.stop()
	$Lazer_Timer.stop()
	$Missile.hide()
	$Trump.hide()
	$Dead_explosion.show()
	$AnimationPlayer.play("Death_Explosion")
	yield($AnimationPlayer,"animation_finished")
	PlayerInfo.change_score(+800)
	queue_free()

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


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if side == "Left":
			PlayerInfo.change_health(-1)
		else:
			PlayerInfo.change_health(+1)


								 ###        MISSILE CODE       ###									


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
	e.look_at(Vector2(e.position.x, e.position.y-1000))
	missles_shot += 1
 
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



									###       LAZER CODE       ###											


func lazer():
	$Go.stop()
	move = false
	behaviour = 0
	target.x = position.x
	target.y = position.y
	$Walk.hide()
	$Lazer.show()
	$AnimationPlayer.play("lazer open")
	yield($AnimationPlayer,"animation_finished")
	print("Firing lazer")
	$AnimationPlayer.play("lazer")
	$Lazer_Position.show()
	$Lazer_Position/Lazer.show()
	$Lazer_Position/Lazer/RayCast2D.set_enabled(true)
	$Lazer_Position/Lazer.enabled = true
	$Lazer_Timer.start()
	$Lazer_Position/Lazer/hitscan.start()

func _on_Lazer_Timer_timeout():
	print("IVE STOPPED FIRING MY LAZER BEAM")
	$Lazer_Position.hide()
	$Lazer_Position/Lazer.hide()
	$Lazer_Position/Lazer/hitscan.stop()
	$Lazer_Position/Lazer/RayCast2D.set_enabled(false)
	$Lazer_Position/Lazer.enabled = false
	$AnimationPlayer.play_backwards("lazer open")
	yield($AnimationPlayer,"animation_finished")
	$Lazer.hide()
	$Idle.show()
	$AnimationPlayer.play("Idle")
	$Pause.start()





func _on_Attack_Timer_timeout():
	attacking = false





