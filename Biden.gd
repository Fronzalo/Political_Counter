extends KinematicBody2D

#export (Position2D) var pathfinder = get_parent().get_node("Bidens pathfinding")

onready var player = get_parent().get_node("Player")
var movement
var size
onready var target = Vector2.ZERO
var side = "left"
var speed = 100
var started = false
var moving 
var body
var hit
var firing = false
var lazering
var spawn
var sg_target_x = 0
var sg_target_y = 0
var pellets
var spawn_number
var clip
var clip_fired = 0
var health = 20
onready var bullet = preload("res://Enemyprojectile.tscn")
var enemy = preload("res://Enemy.tscn")
var shootingenemy = preload("res://Shootingenemy.tscn")
var bs = 0
func _ready():
	add_to_group("enemies")
	size = get_viewport().get_visible_rect().size
	side = "left"
	$Shotgun.hide()
	$Position2D.hide()
	$"Lazer texture".hide()
	$AnimationPlayer.play("Idle")
	$Biden.show()
	print(position)

func change_health(amount):
	health =- amount

func get_side():
	return(side)

func _physics_process(delta):
	if started == false:
		if global_position.x != size.x/2 and global_position.y != size.y/2: #((512, 300)
			target.x = size.x/2
			target.y = size.y/2
			position = position.move_toward(target,speed * delta)
		else:
			started = true
			$Go.start()
	else:
		if moving == 1:
			target = player.position
			target.y -= 170
			position = position.move_toward(target,delta * speed)
		elif moving == 3:
			position = position.move_toward(target,delta * speed)
			
			if position == target and spawn == 1:
				biden_spawn_phase()
		elif moving == 4:
			target = player.position
			target.x += sg_target_x
			target.y += sg_target_y
			position = position.move_toward(target,delta * speed)
		else:
				target.x = size.x/2
				target.y = size.y/2
				position = position.move_toward(target,speed * delta)
	if firing == true:
		if clip_fired < clip:
			shoot()
			clip_fired += 1
		else:
			$Shotgun_Timer.stop()
			$Position2D.hide()
			$Biden.hide()
			$Holster.show()
			$Biden_Charged.hide()
			$AnimationPlayer.play("holster")
			yield($AnimationPlayer, "animation_finished")
			$Holster.hide()
			$Biden.show()
			firing = false
			$Go.start()
	if health <= 0 and health >= -5:
		health = -10
	if health == -10:
		explode()
		health = -9
func explode():
	speed = 0
	$Go.stop()
	$Shotgun.hide()
	$Lazertimer.stop()
	$Biden_Charged.hide()
	$Holster.hide()
	$Biden.show()
	$EXPLODE.show()
	$Lazer_animation/AnimationPlayer.play("Explode")
	yield($Lazer_animation/AnimationPlayer,"animation_finished")
	queue_free()
	PlayerInfo.change_score(+800)




func _on_Go_timeout():
	movement = round(rand_range(1,7))
	print(movement)
	if movement == 1:
		$Go.stop()
		$AnimationPlayer.play("Idle")
		$Movement.play("figure_8")
		yield($Movement, "animation_finished")
		$Go.start()
	elif movement == 2: 
		$Go.stop()
		$AnimationPlayer.play("Idle")
		$Movement.play("loop")
		yield($Movement, "animation_finished")
		$Go.start()
	elif movement == 3:
		$Go.stop()
		$AnimationPlayer.play("Idle")
		$Movement.play("zoom")
		yield($Movement, "animation_finished")
		$Go.start()
	elif movement == 4:
		lazer()
	elif movement == 5:
		$Go.stop()
		$AnimationPlayer.play("Idle")
		target.y = round(rand_range(300,500))
		target.x = round(rand_range(0,size.x))
		moving = 3
		spawn = 1
	elif movement == 6:
		clip = round(rand_range(3,7))
		clip_fired = 0
		$Go.stop()
		$Biden.hide()
		$Shotgun.show()
		$AnimationPlayer.play("shotgun")
		yield($AnimationPlayer,"animation_finished")
		$Shotgun.hide()
		$Biden.show()
		$AnimationPlayer.play("Idle")
		$Position2D.show()
		$Shotgun_Timer.start()
		moving = 4
		$side_timer.start()
		

func lazer():
	$Go.stop()
	$hitscan.start()
	moving = 1
	$Biden.hide()
	$Biden_Charged.show()
	$AnimationPlayer.play("charged")
	yield($AnimationPlayer, "animation_finished")
	$Biden.show()
	$Biden_Charged.hide()
	$AnimationPlayer.play("Idle")
	$Lazer_animation/AnimationPlayer.play("lazerflash")
	$Lazer_animation.play("lazerbegin")
	$Lazer_hitcast.set_enabled(true)
	$hitscan.start()
	yield(get_tree().create_timer(6.0), "timeout")
	$Lazer_animation.play("Lazer end")
	$hitscan.stop()
	$Lazer_hitcast.set_enabled(false)
	$Go.start()
	moving = 0

func biden_spawn_phase():
	spawn = 0
	$AnimationPlayer.play("charged")
	$Movement.play("enemy_spawn")
	$when_spawn.start()
	yield($Movement,"animation_finished")
	$AnimationPlayer.play("Idle")

	



func _on_hitscan_timeout():
	var body = $Lazer_hitcast.get_collider()
	if body:
		if body.name == "Player":
			PlayerInfo.change_health(-1)
			print(PlayerInfo.get_health())


func _on_when_spawn_timeout():
	spawn_number = round(rand_range(5,9))
	print(spawn_number)
	for _i in range(spawn_number):
		bs = floor(rand_range(1,3))
		if bs == 1:
			bs = enemy
		elif bs == 2:
			bs = shootingenemy
		var biden_spawn = bs.instance()
		biden_spawn.position.x = global_position.x + round(rand_range(-50,50))
		biden_spawn.position.y = global_position.y + round(rand_range(50,100))
		get_parent().add_child(biden_spawn)
		biden_spawn.side = "left"
	moving = 0
	movement = 0
	$Go.start()

func shoot():
	print(pellets)
	for _i in range(pellets):
		var e = bullet.instance()
		get_parent().add_child(e)
		e.transform = $Position2D/Sprite/Bullet_Point.global_transform
		e.rotation_degrees += rand_range(-25,25)
		e.scale.y += 2
		e.scale.x += 2 
		print(e.rotation_degrees)
		e.side = "left"
	firing = false



func _on_Shotgun_Timer_timeout():
	pellets = floor(rand_range(3,6))
	firing = true
	if $Biden.flip_h == true:
		$Lazer_animation.play("shoot_reversed")
	else:
		$Lazer_animation.play("shoot")
	yield($Lazer_animation,"animation_finished")


func _on_side_timer_timeout():
	sg_target_x = floor(rand_range(0,2))
	if sg_target_x == 0:
		sg_target_x = -1*(rand_range(1,3)*200)
	else:
		sg_target_x = rand_range(1,3)*200
	
	sg_target_y = floor(rand_range(0,2))
	if sg_target_y == 0:
		sg_target_y = -1*(rand_range(1,3)*200)
	else:
		sg_target_y = rand_range(1,3)*200
	
